import 'package:fluttertodo/services/firestore_backend.dart';

import '../model/task.dart';
import 'local_storage.dart';

class MyController {
  static Future<List<Task>> getTasks() {
    return FirestoreBackend.getTasks();
   }

  static Future<void> deleteTask(Task task) {
    return FirestoreBackend.removeTask(task);
  }

  static Future<Task> addTask(String description, [DateTime dueDate]) {
    return FirestoreBackend.insertTask(description, dueDate);
  }
}