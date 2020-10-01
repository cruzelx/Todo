import 'package:bloc_provider_test/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListCardWidget extends StatelessWidget {
  Task task;
  VoidCallback onDelete;
  VoidCallback onEdit;
  Function(bool) onComplete;
  ListCardWidget(
      {Key key,
      @required this.task,
      @required this.onDelete,
      @required this.onEdit,
      @required this.onComplete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: CheckboxListTile(
        value: task.isComplete,
        onChanged: onComplete,
        title: Text(
          task.activity,
          style: TextStyle(
              decoration: task.isComplete
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
      ),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        IconSlideAction(
            color: Theme.of(context).scaffoldBackgroundColor,
            iconWidget: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.edit, color: Colors.white),
            ),
            onTap: onEdit),
        IconSlideAction(
          color: Theme.of(context).scaffoldBackgroundColor,
          iconWidget: CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.delete, color: Colors.white),
          ),
          onTap: onDelete,
        )
      ],
    );
  }
}
