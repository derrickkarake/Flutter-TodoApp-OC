import '../model/task.dart';
import 'local_storage.dart';

class MyController {
  static Future<List<Task>> getTasks() {
     return LocalStorage.getTasks();
   }

  static Future<void> deleteTask(Task task) {
    return LocalStorage.removeTask(task);
  }

  static Future<Task> addTask(String description, [DateTime dueDate]) {
    return LocalStorage.insertTask(description, dueDate);
  }

  static Future<void> initialize() {
    return LocalStorage.initialize();
  }
}