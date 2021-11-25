import 'package:flutter/material.dart';
import './api.dart';

class ToDoItem {
  String? id;
  String? toDoText;
  bool isDone;

  ToDoItem({this.id, this.toDoText, this.isDone = false});

  void toggleDone(ToDoItem task) {
    isDone = !isDone;
  }

  static Map<String, dynamic> toJson(ToDoItem task) {
    return {
      'title': task.toDoText,
      'id': task.id,
      'done': task.isDone,
    };
  }

  static ToDoItem fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      id: json['id'],
      toDoText: json['title'],
      isDone: json['done'],
    );
  }
}

class MyState extends ChangeNotifier {
  late List<ToDoItem> _list = [];
  int _filterBy = 1;
  int get filterBy => _filterBy;

  List<ToDoItem> get list => _list;

  get value => null;

  Future getList() async {
    List<ToDoItem> list = await Api.getTasks();
    _list = list;
    notifyListeners();
  }

//lägger till i listan
  void addTask(task) async {
    _list = await Api.addTask(task.id);
    notifyListeners();
  }

//tar bort från listan
  void removeTask(ToDoItem task) async {
    _list = await Api.deleteTask(task.id.toString());
    notifyListeners();
  }

//vid ändring av checkbox
  void isDone(ToDoItem task) async {
    _list = await Api.changeTask(task.id.toString());
    notifyListeners();
  }

//sätter variabel och tar in ett argument i form av int
  void setFilterBy(int filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
