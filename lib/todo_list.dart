import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_list_state.dart';

class ToDoList extends StatelessWidget {
  final List<ToDoItem> list;

  const ToDoList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: list.map((task) => _listItem(context, task)).toList());
  }

  Widget _listItem(context, task) {
    return ListTile(
      leading: Checkbox(
        value: task.isDone,
        onChanged: (bool? value) {
          task.isDone = value;
        },
      ),
      title: Text(task.toDoText),
      trailing: const Icon(Icons.highlight_remove),
      onTap: () {
        var state =
            Provider.of<MyState>(context, listen: false).setTaskChecked(task);
      },
    );
  }
}
