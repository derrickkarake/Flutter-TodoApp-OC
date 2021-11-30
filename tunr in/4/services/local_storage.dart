import 'package:flutter/material.dart';
import 'package:fluttertodo/utils/date_converter.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task.dart';

class LocalStorage {
  static Future<Database> _database;
  static const _tasksTable = 'tasks';

  static Future<void> initialize() async {
    if (_database != null) return;

    final name = join(await getDatabasesPath(), 'todo.db');
    await deleteDatabase(name);

    _database = openDatabase(
      name,
      onCreate: _onCreate,
      version: 1,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $_tasksTable (
  task_id INTEGER PRIMARY KEY AUTOINCREMENT,
  description TEXT NOT NULL, 
  due_date INTEGER
);
''');
    return db.execute('''
INSERT INTO $_tasksTable (description, due_date)
  VALUES ("task 3",'1627202425079');
''');
  }

  static Future<List<Task>> getTasks() async {
    final db = await _database;


   final List<Map<String, dynamic>> results = await db.query(_tasksTable,);


   return List.generate(results.length, (index) {
     return Task(
        description: results[index]['description'],
        id: results[index]['task_id'],
        dueDate: (DateTime.fromMillisecondsSinceEpoch(results[index]['due_date'])),
     );
   });

  }

  static Future<Task> insertTask(String description,[DateTime dueDate]) async {
    final db = await _database;
    var Datetomil = toDateTime(dueDate);
    var result;

    Map<String,dynamic> toMap = {
      'due_date':Datetomil,
      'description': '$description'
    };

    result = await db.insert(_tasksTable, toMap);

   Task(id: result, description: '$description', dueDate: dueDate);

   return Task();

  }

  static Future<void> removeTask(Task task) async {
    final db = await _database;

    await db.delete(_tasksTable, where:'task_id = ?', whereArgs: [task.id]);
    return null;
  }
}

