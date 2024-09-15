import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/workout_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('workouts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE workouts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        dateTime TEXT,
        exercises TEXT
      )
    ''');
  }

  Future<int> insertWorkout(Workout workout) async {
    final db = await instance.database;
    return await db.insert('workouts', workout.toMap());
  }

  Future<List<Workout>> getWorkouts() async {
    final db = await instance.database;
    final result = await db.query('workouts');
    return result.map((json) => Workout.fromMap(json)).toList();
  }

  Future<int> deleteWorkout(int id) async {
    final db = await instance.database;
    return await db.delete('workouts', where: 'id = ?', whereArgs: [id]);
  }
}
