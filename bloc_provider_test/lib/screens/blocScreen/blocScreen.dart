import 'package:bloc_provider_test/bloc/taskBloc/task_bloc.dart';
import 'package:bloc_provider_test/bloc/taskBloc/task_event.dart';
import 'package:bloc_provider_test/components/dialogManager.dart';
import 'package:bloc_provider_test/constants/constants.dart';
import 'package:bloc_provider_test/models/models.dart';
import 'package:bloc_provider_test/provider/taskViewModel.dart';
import 'package:bloc_provider_test/components/addTaskWidget.dart';
import 'package:bloc_provider_test/components/listCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class BlocScreen extends StatefulWidget {
  @override
  _BlocScreenState createState() => _BlocScreenState();
}

class _BlocScreenState extends State<BlocScreen> {
  final _bloc = TaskBloc();

  @override
  void initState() {
    // TODO: implement initState
    _bloc.taskEventSink.add(FetchTasks());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final newTask =
              await DialogManager.bottomSheetManager(child: AddTaskWidget());

          if (newTask == null) {
            DialogManager.showCustomToast(
                message: "The process was cancelled by user",
                buttonTitle: "Okay");
          } else {}
        },
      ),
      appBar: AppBar(
        title: Text("Bloc Task Screen"),
      ),
      body: StreamBuilder(
        stream: _bloc.tasks,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null || snapshot.data == []) {
            return Center(child: Text("No Tasks"));
          }

          return RefreshIndicator(
            displacement: 40.0,
            onRefresh: () async {
              return _bloc.taskEventSink.add(FetchTasks());
            },
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                Task task = snapshot.data[index];
                return ListCardWidget(
                  task: task,
                  onComplete: (val) async {
                    _bloc.taskEventSink.add(CompleteTask(val, index));
                  },
                  onDelete: () async {
                    _bloc.taskEventSink.add(DeleteTask(index));
                  },
                  onEdit: () async {
                    final updatedTask = await DialogManager.bottomSheetManager(
                        child: AddTaskWidget(task: task));

                    _bloc.taskEventSink.add(UpdateTask(updatedTask, index));
                  },
                );
              },
              separatorBuilder: (_, index) {
                return Divider();
              },
            ),
          );
        },
      ),
    );
  }
}
