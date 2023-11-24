import 'dart:async';

import 'package:fyprahmah/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'dataB.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT, password INTEGER)",
      );
    },
    version: 1,
  );

  Future<void> insertUser(User user) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> user() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('user');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['title'],
        password: maps[i]['price'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      'user',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'user',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  var b1 = User(
    id: 0,
    username: 'Let Us C',
    password: 333,
  );

  await insertUser(b1);

  print(await user());

  b1 = User(
    id: b1.id,
    username: 'Nabiha123',
    password: 12345678,
  );
  await updateUser(b1);

  print(await user());

  await deleteUser(b1.id);

  print(await user());
}

class User {
  final int id;
  final String username;
  final int password;
  User({required this.id, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password}';
  }
}