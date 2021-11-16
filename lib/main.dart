import 'package:flutter/material.dart';
import 'ToDoListState.dart';
//import 'andrafilen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        title: Text('Tig169 To-Do'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_drop_down_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: _list(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondView()));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _list() {
    return ListView(
      children: [
        _item("Handla mat"),
        _item("Klappa katterna"),
        _item("Hinna till Systemet"),
        _item("Ordna vattenlåset"),
        _item("SMSa farmor"),
      ],
    );
  }

  Widget _item(strText) {
    return ListTile(
      leading: Icon(Icons.check_box_outline_blank),
      title: Text(strText),
      trailing: Icon(Icons.close),
    );
  }
}

//--------------------Second view-----------------------------
class SecondView extends StatelessWidget {
  get inputText => TextEditingController();

  get Provider => null;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        //lägger till de fina färgerna

        title: Text('Lägg till nya påminnelser'),
        centerTitle: true, //Texten i mitten
      ),
      body: Column(
        children: [
          ///Hämtar metoden _inputTask
          _inputTask(),
          _addButton()

          ///Tillropar addButton
        ],
      ),
    );
  }

  Widget _inputTask() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: inputText,
        decoration: InputDecoration(hintText: "Skriv in här"),
      ),
    );
  }

  Widget _addButton() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            var newTask = inputText.text;
            Provider.of<TodoListState>(listen: false).addListItem(newTask);
            inputText.clear();
          },
          icon: const Icon(Icons.post_add_outlined),
        ),
        const Text('Add to list')
      ],
    );
  }
}
/*
  Widget _addText() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 180),
          child: Icon(Icons.add),
        ),
        Container(
          margin: EdgeInsets.only(left: 180),
          child: Text("Add"),
        )
      ],
    );
  }
}*/

