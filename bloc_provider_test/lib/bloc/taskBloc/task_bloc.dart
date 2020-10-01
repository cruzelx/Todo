import 'dart:async';

import 'package:bloc_provider_test/bloc/taskBloc/task_event.dart';
import 'package:bloc_provider_test/locator/locator.dart';
import 'package:bloc_provider_test/models/models.dart';
import 'package:bloc_provider_test/services/services.dart';

class TaskBloc {
  TaskBloc() {
    _taskEventController.stream.listen(_mapEventToState);
  }

  final TaskService _taskService = locator<TaskService>();

  final StreamController<List<Task>> _taskStateController =
      StreamController<List<Task>>.broadcast();

  Stream<List<Task>> get tasks => _taskStateController.stream;

  StreamSink<List<Task>> get _inTasks => _taskStateController.sink;

  final StreamController<TaskEvent> _taskEventController =
      StreamController<TaskEvent>.broadcast();

  Sink<TaskEvent> get taskEventSink => _taskEventController.sink;

  void _mapEventToState(TaskEvent event) async {
    if (event is FetchTasks) {
      List<Task> tasks = await _taskService.fetchTasks();
      _inTasks.add(tasks);
    } else if (event is CreateTask) {
      await _taskService.createTask(event.newTask);
      List<Task> tasks = await _taskService.fetchTasks();
      _inTasks.add(tasks);
    } else if (event is UpdateTask) {
      await _taskService.updateTask(event.updateTask, event.index);
      List<Task> tasks = await _taskService.fetchTasks();
      _inTasks.add(tasks);
    } else if (event is DeleteTask) {
      await _taskService.deleteTask(event.index);
      List<Task> tasks = await _taskService.fetchTasks();
      _inTasks.add(tasks);
    } else if (event is CompleteTask) {
      List<Task> tasks = await _taskService.fetchTasks();
      tasks[event.index].isComplete = event.val;
      await _taskService.updateTask(tasks[event.index], event.index);
      _inTasks.add(tasks);
    }
  }

  void dispose() {
    _taskEventController.close();
    _taskStateController.close();
  }
}
