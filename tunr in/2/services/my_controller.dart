import 'package:todo_app/model/task.dart';

import 'fake_data.dart';

class MyController {
  static List<Task> getTasks() {
    return FakeData.getTasks();
  }
}
