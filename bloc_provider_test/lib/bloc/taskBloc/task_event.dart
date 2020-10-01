import 'package:bloc_provider_test/models/models.dart';

abstract class TaskEvent {}

class FetchTasks extends TaskEvent {}

class CreateTask extends TaskEvent {
  final Task newTask;
  CreateTask(this.newTask);
}

class UpdateTask extends TaskEvent {
  final Task updateTask;
  final int index;
  UpdateTask(this.updateTask, this.index);
}

class DeleteTask extends TaskEvent {
  final int index;
  DeleteTask(this.index);
}

class CompleteTask extends TaskEvent {
  final bool val;
  final int index;
  CompleteTask(this.val, this.index);
}
