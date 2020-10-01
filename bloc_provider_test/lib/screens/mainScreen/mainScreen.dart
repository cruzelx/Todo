import 'package:bloc_provider_test/components/dialogManager.dart';
import 'package:bloc_provider_test/constants/constants.dart';
import 'package:bloc_provider_test/models/models.dart';
import 'package:bloc_provider_test/provider/taskViewModel.dart';
import 'package:bloc_provider_test/components/addTaskWidget.dart';
import 'package:bloc_provider_test/components/listCardWidget.dart';
import 'package:bloc_provider_test/screens/mainScreen/components/sideNav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskViewModel(),
      child: Consumer<TaskViewModel>(
        builder: (_, taskNotifier, child) {
          return Scaffold(
              drawer: Drawer(
                child: SideNav(),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final newTask = await DialogManager.bottomSheetManager(
                      child: AddTaskWidget());

                  if (newTask == null) {
                    DialogManager.showCustomToast(
                        message: "The process was cancelled by user",
                        buttonTitle: "Okay");
                  } else {
                    await taskNotifier.addTask(newTask);
                  }
                },
              ),
              appBar: AppBar(
                title: Text("Provider Task Screen"),
              ),
              body: Builder(builder: (_) {
                if (taskNotifier.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (taskNotifier.tasks == null || taskNotifier.tasks == []) {
                  return Center(child: Text("No Tasks"));
                }

                return RefreshIndicator(
                  displacement: 40.0,
                  onRefresh: () {
                    return taskNotifier.fetchTasks();
                  },
                  child: ListView.separated(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: taskNotifier.tasks.length,
                    itemBuilder: (_, index) {
                      Task task = taskNotifier.tasks[index];
                      return ListCardWidget(
                        task: task,
                        onComplete: (val) async {
                          taskNotifier.onComplete(val, index);
                        },
                        onDelete: () async {
                          await taskNotifier.deleteTask(index);
                        },
                        onEdit: () async {
                          final updatedTask =
                              await DialogManager.bottomSheetManager(
                                  child: AddTaskWidget(task: task));

                          await taskNotifier.updateTask(updatedTask, index);
                        },
                      );
                    },
                    separatorBuilder: (_, index) {
                      return Divider();
                    },
                  ),
                );
              }));
        },
      ),
    );
  }
}
