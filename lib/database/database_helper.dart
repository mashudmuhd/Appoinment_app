import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/appoinment_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'myAppointments';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'myAppointments.db');
    return await openDatabase(path,
        version: 2, onCreate: _createDatabase, onUpgrade: _upgradeDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        place TEXT,
        amount REAL,
        comments TEXT,
        date TEXT,
        time TEXT
      )
    ''');
  }

  Future<void> _upgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1 && newVersion == 2) {
      await db.execute('ALTER TABLE $tableName ADD COLUMN name TEXT');
    }
  }

  Future<int> insertAppointment(Appointment appointment) async {
    final db = await database;

    int id = await db.insert(tableName, appointment.toMap());
    return id;



  }

  Future<List<Appointment>> getAppointments() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Appointment.fromMap(maps[i]);
    });
  }

  Future<int> deleteAppointment(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAppointment(Appointment appointment) async {
    final db = await database;

    try {
      if (appointment.id != null && appointment.id != 0) {
        return await db.update(
          tableName,
          appointment.toMap(),
          where: 'id = ?',
          whereArgs: [appointment.id],
        );
      } else {
        // Handle the case where the appointment ID is not valid
        return 0;
      }
    } catch (e) {
      print('Error updating appointment: $e');
      return 0; // Return 0 to indicate update failure
    }
  }

}
