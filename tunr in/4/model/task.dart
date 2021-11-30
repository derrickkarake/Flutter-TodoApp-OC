import 'package:flutter/foundation.dart';

class Task {
  bool isCompleted;
  final String description;
  final DateTime dueDate;
  final String id;

  Task({
    this.description = '',
    @required this.id,
    this.dueDate,
    this.isCompleted = false,
  }) {
    assert(description != null);
  }
}
