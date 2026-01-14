import 'package:flutter/material.dart';
import 'package:medicine_reminder/models/medicine.dart';
import 'package:provider/provider.dart';
import '../controller/medicine_controller.dart';
import 'add_medicine_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MedicineController>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Medicine Reminder',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal, 
        elevation: 4,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal[100],
              ),
              child: const Icon(
                Icons.medical_services,
                size: 60,
                color: Colors.teal,
              ),
            ),
          ),

          const SizedBox(height: 16),

          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Stay Healthy! Add your medicines below and get timely reminders.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 20),

    
          Expanded(
            child: controller.medicines.isEmpty
                ? const Center(
                    child: Text(
                      'No medicines added yet',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80, top: 10),
                    itemCount: controller.medicines.length,
                    itemBuilder: (context, index) {
                      Medicine medicine = controller.medicines[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          title: Text(
                            '💊 ${medicine.name}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '⏰ ${medicine.dose} • ${_formatTime(medicine.time)}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, size: 26),
                            color: Colors.deepOrange, // Orange accent
                            onPressed: () {
                              controller.deleteMedicine(medicine.id!);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Medicine deleted'),
                                  backgroundColor: Color.fromARGB(255, 181, 9, 23),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange, 
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
