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
  int _filterBy = 3;

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
  void removeTask(ToDoItem taskId) async {
    _list = await Api.deleteTask(taskId);
    notifyListeners();
  }

  void updatedTask(ToDoItem task) async {
    task.toggleDone(task);
    _list = await Api.updateTask(task.id, task);
    notifyListeners();
  }

//vid ändring av checkbox
  void isDone(ToDoItem task) async {
    task.toggleDone(task);
    notifyListeners();
  }

//sätter variabel och tar in ett argument i form av int
  void setFilterBy(int filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
