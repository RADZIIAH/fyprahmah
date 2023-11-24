import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static late Database _database;

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'menu.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE menu (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL
      )
    ''');
  }

  Future<int> insertMenu(Map<String, dynamic> menu) async {
    Database db = await database;
    return await db.insert('menu', menu);
  }

  Future<List<Map<String, dynamic>>> getMenu() async {
    Database db = await database;
    return await db.query('menu');
  }
}
