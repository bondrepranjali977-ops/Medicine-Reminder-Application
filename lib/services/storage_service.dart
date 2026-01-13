import 'package:medicine_reminder/models/medicine.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class StorageService {
  Database? _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'medicine.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE medicines('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'name TEXT, '
          'dose TEXT, '
          'time TEXT'
          ')',
        );
      },
    );
  }

  Future<int> insertMedicine(Medicine medicine) async {
    return await _database!.insert('medicines', {
      'name': medicine.name,
      'dose': medicine.dose,
      'time': medicine.time.toIso8601String(),
    });
  }

  Future<List<Medicine>> getMedicines() async {
    final List<Map<String, dynamic>> data = await _database!.query('medicines');

    return List.generate(data.length, (i) {
      return Medicine(
        id: data[i]['id'],
        name: data[i]['name'],
        dose: data[i]['dose'],
        time: DateTime.parse(data[i]['time']),
      );
    });
  }

  Future<void> deleteMedicine(int id) async {
    await _database!.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }
}
