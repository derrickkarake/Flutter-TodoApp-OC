import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';
import '../utils/date_converter.dart';

class FirestoreBackend {
  static const _tasks = 'tasks';
  static const _description = 'description';
  static const _dueDate = 'due_date';
  static const _isCompleted = 'is_completed';

  static Future<List<Task>> getTasks() async {

    // TODO get all tasks in the tasks collection using Firestore.instance
    // TODO convert each document's data to a Task. For the due date, you will need to use toDateTime() which can be found at lib/utils/date_converter.dart
    // TODO return the result as a List

    return [];
  }

  static Future<Task> insertTask(String description, DateTime dueDate) async {
    // TODO Insert (add) a document in the tasks collection and assigning the result to a variable.
    // TODO After it is inserted, return a Task where the id is the new document's documentID.

    return null;
  }

  static Future<void> removeTask(Task task) {
    // TODO remove task and return the result
    return Firestore.instance.collection(_tasks).document(task.id).delete();
  }
}
