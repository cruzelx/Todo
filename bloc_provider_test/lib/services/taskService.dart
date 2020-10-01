import 'dart:async';

import 'package:bloc_provider_test/constants/constants.dart';
import 'package:bloc_provider_test/models/models.dart';

class TaskService {
  // StreamController<List<Task>> _tasksStreamController =
  //     StreamController<List<Task>>.broadcast();

  // Stream<List<Task>> tasksStream() {
  //   _tasksStreamController.add(taskData);
  //   return _tasksStreamController.stream;
  // }

  Future<List<Task>> fetchTasks() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return taskData;
    });
  }

  Future<void> createTask(Task task) async {
    return await Future.delayed(const Duration(seconds: 2), () {
      taskData.add(task);
    });
  }

  Future<void> updateTask(Task task, int index) async {
    return await Future.delayed(const Duration(seconds: 2), () {
      taskData[index] = task;
    });
  }

  Future<void> deleteTask(int index) async {
    return await Future.delayed(const Duration(seconds: 2), () {
      taskData.removeAt(index);
    });
  }
}
