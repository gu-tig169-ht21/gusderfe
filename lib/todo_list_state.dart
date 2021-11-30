import 'package:flutter/material.dart';
import './api.dart';

class ToDoItem {
  String id;
  String? toDoText;
  bool isDone;

  ToDoItem({required this.id, required this.toDoText, this.isDone = false});

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
      toDoText: json['title'],
      id: json['id'],
      isDone: json['done'],
    );
  }
}

class MyState extends ChangeNotifier {
  late List<ToDoItem> _list = [];
  int _filterBy = 1;

  List<ToDoItem> get list => _list;
  int get filterBy => _filterBy;

  // get value => null;

  Future getList() async {
    List<ToDoItem> list = await Api.getTasks();
    _list = list;
    notifyListeners();
  }

//lägger till i listan
  void addTask(task) async {
    _list = await Api.addTask(task);
    notifyListeners();
  }

//tar bort från listan
  void deleteTask(ToDoItem taskId) async {
    _list = await Api.delete(taskId);
    notifyListeners();
  }

  void updateTask(ToDoItem task) async {
    task.toggleDone(task);
    _list = await Api.update(task.id, task);
    notifyListeners();
  }

//sätter variabeln för filtrering och tar in ett argument i form av int
  void setFilterBy(int filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
