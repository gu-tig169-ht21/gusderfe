import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_list_state.dart';
import 'second_view.dart';
import 'todo_list.dart';

class TodolistView extends StatelessWidget {
  const TodolistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('To-Do List App'),
        elevation: 0,
        actions: [
          PopupMenuButton<int>(
              icon: const Icon(Icons.more_horiz_outlined),
              onSelected: (int value) {
                Provider.of<MyState>(context, listen: false).setFilterBy(value);
              },
              itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Alla"),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text("Klara"),
                      value: 2,
                    ),
                    const PopupMenuItem(
                      child: Text("Ogjorda"),
                      value: 3,
                    )
                    //detta är för filtrering
                  ])
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>
            ToDoList(_filterList(state.list, state.filterBy)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 42),
        onPressed: () async {
          var newToDo = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SecondView(ToDoItem(toDoText: 'title'))));
          // Kommer till Andra vyn

          if (newToDo != null) {
            // Lägg till ny Task i ToDolistan
            Provider.of<MyState>(context, listen: false).addTask(newToDo);
          }
        },
      ),
    );
  }

  //filtrerar efter value
  List<ToDoItem> _filterList(list, filterBy) {
    if (filterBy == 1) {
      return list;
    }
    if (filterBy == 2) {
      return list.where((item) => item.isDone == true).toList();
    }
    if (filterBy == 3) {
      return list.where((item) => item.isDone == false).toList();
    }
    return list;
  }
}
