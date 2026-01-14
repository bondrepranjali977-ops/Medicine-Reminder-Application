
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/medicine_controller.dart';
import '../models/medicine.dart';
import '../services/notification_service.dart';


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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('💉🩺 Add Medicine', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Top logo
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.teal[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.medical_services,
                color: Colors.teal,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              '💊💉 Keep Track of Your Medicines! 🩺⏰',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: '💊 Medicine Name ',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                ),
              ),
            ),

            const SizedBox(height: 16),

            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: doseController,
                decoration: const InputDecoration(
                  labelText: '💊 Dose ',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                ),
              ),
            ),

            const SizedBox(height: 20),

            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedTime == null
                        ? '⏰ Select Time here'
                        : '⏰ Time: ${selectedTime!.format(context)}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Pick Time '),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

           
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      doseController.text.isEmpty ||
                      selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('⚠️ Please fill all details'),
                        backgroundColor: Colors.deepOrange,
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
                        '💊 It’s time to take your medicine: ${nameController.text}\nDose: ${doseController.text}',
                    scheduledTime: medicineTime,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Medicine added successfully!!'),
                      backgroundColor: Colors.teal,
                    ),
                  );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('✅Save '),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
