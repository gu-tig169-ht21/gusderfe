import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_list_state.dart';
import 'todo_list_view.dart';

class ToDoList extends StatelessWidget {
  List<ToDoItem> list;

  ToDoList(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: list.map((task) => _listItem(context, task)).toList());
  }

  Widget _listItem(context, task) {
    var state = Provider.of<MyState>(context, listen: false);
    return ListTile(
        leading: Checkbox(
          value: task.isDone,
          onChanged: (value) {
            state.updatedTask(task);
          },
        ),
        title: Text(task.toDoText,
            style: TextStyle(
                decoration: task.isDone ? TextDecoration.lineThrough : null)),
        trailing: IconButton(
            onPressed: () {
              var state = Provider.of<MyState>(context, listen: false);
              state.removeTask(task);
            },
            icon: Icon(Icons.highlight_remove)));
  }
}
