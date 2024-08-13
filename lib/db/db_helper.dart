import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? db;
  static const int version = 1;
  static const String tableName = 'tasks';

  static initDb() async {
    if (db != null) {
      debugPrint('not null db');
      return;
    }
    try {
      String path = '${await getDatabasesPath()}task.db';
      debugPrint('in db path');
      db = await openDatabase(path, version: version,
          onCreate: (Database db, int version) async {
        debugPrint('create new db');
        return db.execute('CREATE TABLE $tableName ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, '
            'note TEXT, date STRING, startTime STRING, '
            'endTime STRING, remind INTEGER, repeat STRING, '
            'color INTEGER, isCompleted INTEGER)');
      });
      debugPrint('db created');
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    return await db!.insert(tableName, task!.toJson());
  }

  static Future<int> delete(Task task) async {
    return await db!.delete(tableName, whereArgs: [task.id], where: 'id=?');
  }

  static Future<int> deleteAll() async {
    return await db!.delete(tableName);
  }

  static Future<int> update(int id) async {
    return await db!.rawUpdate('''
UPDATE tasks
SET isCompleted = ?
WHERE id=?
  ''', [1, id]);
  }

  static Future<List<Map<String, Object?>>> query() async {
    return await db!.query(tableName);
  }
}
