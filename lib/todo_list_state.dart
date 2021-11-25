import 'package:flutter/material.dart';
import './api.dart';

class ToDoItem {
  String? toDoText;
  String? id;
  bool isChanged;

  //ToDoItem({this.toDoText});
  ToDoItem({this.id, this.toDoText, this.isChanged = false});

  static Map<String, dynamic> toJson(ToDoItem task) {
    return {
      'title': task.toDoText,
      'id': task.id,
      'done': task.isChanged,
    };
  }

  static ToDoItem fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      id: json['id'],
      toDoText: json['title'],
      isChanged: json['done'],
    );
  }
}

class MyState extends ChangeNotifier {
  List<ToDoItem> _list = [];
  int _filterBy = 1;
  int get filterBy => _filterBy;

  List<ToDoItem> get list => _filterList(_list, _filterBy);

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

    void changeTask(ToDoItem task) async {
      _list = await Api.changeTask(task.id.toString());
      notifyListeners();
    }

    void setTaskChecked(task) {
      task.isDone(task);
      notifyListeners();
    }

//sätter variabel och tar in ett argument i form av int
    void setFilterBy(int filterBy) {
      _filterBy = filterBy;
      notifyListeners();
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
      return [];
      notifyListeners();
    }
  }
}
