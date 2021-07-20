import 'package:flutter/material.dart';

import 'main.dart';

class TaskNotifer extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title, String description) {
    final newTask = Task(
      title: title,
      description: description,
      id: _tasks.length + 1,
    );
    _tasks.add(newTask);
    notifyListeners();
  }
}
