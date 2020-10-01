import 'package:auto_route/auto_route.dart';
import 'package:bloc_provider_test/models/models.dart';
import 'package:flutter/material.dart';

class AddTaskWidget extends StatefulWidget {
  Task task;
  AddTaskWidget({Key key, this.task}) : super(key: key);
  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  bool isEdit;
  Task newTask;

  setInitialValues() {
    isEdit = widget.task != null;
    newTask = isEdit ? widget.task : Task(activity: '', isComplete: false);
  }

  @override
  void initState() {
    // TODO: implement initState
    setInitialValues();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(isEdit ? "Edit Task" : "Add Task",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16.0),
          TextFormField(
            maxLength: 200,
            initialValue: newTask.activity,
            decoration: InputDecoration(prefixIcon: Icon(Icons.edit)),
            onChanged: (val) {
              newTask.activity = val;
            },
          ),
          SizedBox(height: 8.0),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () {
              ExtendedNavigator.root.pop(newTask);
            },
            child: Text(
              isEdit ? "Edit Task" : "Add Task",
            ),
          )
        ],
      ),
    );
  }
}
