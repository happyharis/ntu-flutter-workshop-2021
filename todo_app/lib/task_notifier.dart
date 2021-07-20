import 'package:flutter/material.dart';

import 'main.dart';

class TaskNotifer extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;
}
