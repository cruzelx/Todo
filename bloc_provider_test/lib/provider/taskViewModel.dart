import 'package:bloc_provider_test/components/dialogManager.dart';
import 'package:bloc_provider_test/locator/locator.dart';
import 'package:bloc_provider_test/models/models.dart';
import 'package:bloc_provider_test/services/services.dart';
import 'package:flutter/cupertino.dart';

class TaskViewModel extends ChangeNotifier {
  TaskViewModel() {
    fetchTasks();
  }
  TaskService _taskService = locator<TaskService>();

  List<Task> _tasks;
  List<Task> get tasks => this._tasks;

  bool _isLoading;
  bool get isLoading => this._isLoading;

  set isLoading(bool val) {
    this._isLoading = val;
    notifyListeners();
  }

  validateTask(Task task) {
    if (task.activity != '' && task.activity != null)
      return true;
    else {
      DialogManager.showCustomToast(
          message: "Invalid input", buttonTitle: "okay");
      return false;
    }
  }

  onComplete(bool val, int index) {
    this._tasks[index].isComplete = val;
    notifyListeners();
  }

  // CRUD
  // Stream<List<Task>> get tasksStream => _taskService.tasksStream();

  Future fetchTasks() async {
    isLoading = true;
    this._tasks = await _taskService.fetchTasks();
    isLoading = false;
  }

  Future<void> addTask(Task task) async {
    if (validateTask(task)) {
      await _taskService.createTask(task);
      await fetchTasks();
    }
  }

  Future<void> updateTask(Task task, int index) async {
    if (validateTask(task)) {
      await _taskService.updateTask(task, index);
      await fetchTasks();
    }
  }

  Future<void> deleteTask(int index) async {
    await _taskService.deleteTask(index);
    await fetchTasks();
  }
}
