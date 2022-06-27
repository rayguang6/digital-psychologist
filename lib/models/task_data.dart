import 'package:digital_psychologist/models/task.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

import 'package:provider/provider.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void deleteAllTask() {
    for (int i = 0; i < _tasks.length; i++) {
      _tasks.remove(_tasks[i]);
    }
    _tasks.clear();
    notifyListeners();
  }
}
