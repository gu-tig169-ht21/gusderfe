import 'package:flutter/material.dart';
import 'todo_list_state.dart';

class SecondView extends StatefulWidget {
  final ToDoItem task;

  SecondView(this.task);

  @override
  State<StatefulWidget> createState() {
    return SecondViewState(task);
  }
}

class SecondViewState extends State<SecondView> {
  String? toDoText;
  late TextEditingController textEditingController;

  SecondViewState(task) {
    this.toDoText = task.toDoText;

    textEditingController = TextEditingController();

    textEditingController.addListener(() {
      setState(() {
        toDoText = textEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lägg till påminnelser')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20),
            //   TaskInputField(ToDoItem(toDoText: this.toDoText)),
            Container(height: 20),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Skriv in här...'),
            ),
            addTask(),
          ],
        ),
      ),
    );
  }

  Widget addTask() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context, ToDoItem(toDoText: toDoText));
          },
          icon: const Icon(Icons.add_task),
        ),
        const Text('Lägg till uppgift')
      ],
    );
  }
}
