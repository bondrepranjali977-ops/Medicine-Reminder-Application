import 'package:flutter/material.dart';
import 'package:medicine_reminder/models/medicine.dart';
import 'package:medicine_reminder/services/storage_service.dart';

class MedicineController with ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<Medicine> medicines = [];

  MedicineController() {
    init();
  }

  Future<void> init() async {
    await _storageService.initDatabase();
    await loadMedicines();
  }

  Future<void> loadMedicines() async {
    medicines = await _storageService.getMedicines();

    medicines.sort((a, b) => a.time.compareTo(b.time));

    notifyListeners();
  }

  
  Future<void> addMedicine(Medicine medicine) async {
    int id = await _storageService.insertMedicine(medicine);
    medicine.id = id;

    medicines.add(medicine);

    medicines.sort((a, b) => a.time.compareTo(b.time));

    notifyListeners();
  }

  
  Future<void> deleteMedicine(int id) async {
    await _storageService.deleteMedicine(id);
    medicines.removeWhere((m) => m.id == id);
    notifyListeners();
  }
}
