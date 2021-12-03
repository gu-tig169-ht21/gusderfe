import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../todo_list_state.dart';
import 'add_task_view.dart';
import '../todo_list.dart';

//------Detta är första sidan i appen------

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
                  ])
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>
            ToDoList(_filterList(state.list, state.filterBy)),
        //---------detta ovan är för filtrering
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add, size: 42),
        onPressed: () async {
          var newToDo = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondView(
                      (ToDoItem(id: '', toDoText: 'Viktigt ärende')))));
          //---Kommer till Andra vyn

          if (newToDo != null) {
            //-----Lägg till ny Task i ToDolistan
            Provider.of<MyState>(context, listen: false).addTask(newToDo);
          }
        },
      ),
    );
  }

  //filtrerar efter value och returnerar filtrerad lista
  List<ToDoItem> _filterList(List<ToDoItem> list, int filterBy) {
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
