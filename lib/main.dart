import 'package:flutter/material.dart';
import 'ToDoListState.dart';
//import 'thirdview.dart';

void main() {
  //  var state = ToDoListState();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //tar bort Debug-flärpen
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
        title: const Text('To-Do List App'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("All"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Done"),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: Text("Undone"),
                      value: 3,
                    )
                  ])
        ],
      ),
      body: _list(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondView()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _list() {
    var assignment = [
      "Handla mat",
      "Klappa katterna",
      "Hinna till Systemet",
      "Ordna vattenlåset",
      "SMSa farmor",
    ];
    return ListView.builder(
        itemCount: assignment.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              _listItems(assignment[index]),
              Divider(
                thickness: 2,
              ),
            ],
          );
        });
  }

  Widget _listItems(assignmentTitle) {
    return ListTile(
      leading: MyCB(),
      title: Text(
        assignmentTitle,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
      ),
    );
  }

  Widget _checkBoxAlt(String assignment) {
    return Row(children: [
      MyCB(),
      Container(
        child: Text(
          assignment,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      IconButton(
        //ta bort något från listan-knappen
        icon: Icon(Icons.delete),
        onPressed: () {},
        //             setState(() {
        //           _toDoInputs.remove(text);
      )
    ]);
  }
}

class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  bool? _myBool = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: _myBool,
        onChanged: (value) {
          setState(() {
            _myBool = value;
          });
        });
  }
}

/*
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
*/

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
          ///Hämtar _inputTask
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
        const Text('Lägg till i lista')
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

