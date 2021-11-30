import 'package:flutter/foundation.dart';

class Task {
  bool isCompleted;
  final String description;
  final int id;
  final DateTime dueDate;

  Task ({this.description = '', @required this.id, this.dueDate}) : isCompleted = false

  {
    assert(description != null);
  }
}
