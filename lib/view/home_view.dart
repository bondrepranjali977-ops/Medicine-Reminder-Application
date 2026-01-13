import 'package:flutter/material.dart';
import 'package:medicine_reminder/models/medicine.dart';
import 'package:provider/provider.dart';

import '../controller/medicine_controller.dart';
import '../utils/app_colors.dart';
import 'add_medicine_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MedicineController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Reminder', style: TextStyle(fontSize: 22)),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),

      body:
          controller.medicines.isEmpty
              ? const Center(
                child: Text(
                  'No medicines added yet',
                  style: TextStyle(fontSize: 18),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: controller.medicines.length,
                itemBuilder: (context, index) {
                  Medicine medicine = controller.medicines[index];

                  return Card(
                    color: Colors.grey.shade50,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        '💊 ${medicine.name}', 
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          '🧪 ${medicine.dose} • ${_formatTime(medicine.time)}',
                          
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, size: 26),
                        color: AppColors.accentColor,
                        onPressed: () {
                          controller.deleteMedicine(medicine.id!);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Medicine deleted'),
                              backgroundColor: AppColors.accentColor,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentColor,
        child: const Icon(Icons.add, size: 30),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedicineView()),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    int hour = time.hour;
    int minute = time.minute;
    String period = hour >= 12 ? 'PM' : 'AM';

    hour = hour > 12 ? hour - 12 : hour;
    hour = hour == 0 ? 12 : hour;

    String min = minute < 10 ? '0$minute' : minute.toString();

    return '$hour:$min $period';
  }
}
