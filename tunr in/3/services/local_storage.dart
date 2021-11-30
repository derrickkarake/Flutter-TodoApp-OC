import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/task.dart';

class LocalStorage {
  static Future<Database> _database;
  static const _tasksTable = 'tasks';

  static Future<void> initialize() async {
    if (_database != null) return;

    final name = join(await getDatabasesPath(), 'todo.db');
   // await deleteDatabase(name);

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
INSERT INTO $_tasksTable (description)
  VALUES ("task 3");
''');
  }

  static Future<List<Task>> getTasks() async {
    final db = await _database;


   final List<Map<String, dynamic>> results = await db.query(_tasksTable,);

var test = DateTime.fromMillisecondsSinceEpoch(results[3]['due_date']);
  // issue with updating

   return List.generate(results.length, (index) {
     return Task(id: results[index]['task_id'],
                description: results[index]['description'],
                dueDate: test,

     );


   });

    // TODO Use db.query to get all tasks from the tasks table
    // TODO Convert the resulting map<String, dynamic> to [Task] objects
    // TODO Convert the resulting Iterable<Task> to List<Task>
    // TODO return the resulting list and remove 'return [];'

    //return [];
  }

  static Future<Task> insertTask(String description,[DateTime dueDate]) async {
    final db = await _database;
    int Datetomil = dueDate.millisecondsSinceEpoch;
    var result;

    Map<String,dynamic> toMap = {
      'due_date':Datetomil,
      'description': '$description'
    };

    result = await db.insert(_tasksTable, toMap);


   Task(id: result, description: '$description', dueDate: dueDate);


   return Task();

    // TODO Use db.insert to create a new task and assign the result to an int
    // TODO Use the resulting id to create a new Task
    // TODO return the resulting task
    //return Task();
  }

  static Future<void> removeTask(Task task) async {
    final db = await _database;

    Map<String, dynamic> row =  {
      'isCompleted': task.isCompleted

    };


    await db.delete(_tasksTable, where:'task_id = ?', whereArgs: [task.id]);
    // TODO Use db.delete to delete the particular task
    return null;
  }
}