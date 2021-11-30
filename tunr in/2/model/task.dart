class Task {
  bool isCompleted;
  final String description;

  Task({this.description = ''}) : isCompleted = false {
    assert(description != null);
  }
}
