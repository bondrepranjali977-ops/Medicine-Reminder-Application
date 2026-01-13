import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/medicine_controller.dart';
import '../models/medicine.dart';
import '../services/notification_service.dart';
import '../utils/app_colors.dart';

class AddMedicineView extends StatefulWidget {
  @override
  State<AddMedicineView> createState() => _AddMedicineViewState();
}

class _AddMedicineViewState extends State<AddMedicineView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController doseController = TextEditingController();

  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MedicineController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Medicine Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: doseController,
              decoration: const InputDecoration(
                labelText: 'Dose',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTime == null
                      ? 'No time selected'
                      : 'Time: ${selectedTime!.format(context)}',
                ),
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (time != null) {
                      setState(() {
                        selectedTime = time;
                      });
                    }
                  },
                  child: const Text('Pick Time'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      doseController.text.isEmpty ||
                      selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Please fill all details'),
                        backgroundColor: AppColors.accentColor,
                      ),
                    );
                    return;
                  }

                  DateTime now = DateTime.now();
                  DateTime medicineTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  );

                  controller.addMedicine(
                    Medicine(
                      name: nameController.text,
                      dose: doseController.text,
                      time: medicineTime,
                    ),
                  );

                  NotificationService.scheduleNotification(
                    id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    title: '💊 Medicine Reminder',
                    body:
                        'It’s time to take your medicine: ${nameController.text}\nDose: ${doseController.text}',
                    scheduledTime: medicineTime,
                  );

                  // Success snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Medicine added successfully'),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
