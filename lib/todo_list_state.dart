import 'package:flutter/material.dart';

class ToDoItem {
  String? toDoText;
  bool isDone = false;

  ToDoItem({this.toDoText});
}

class MyState extends ChangeNotifier {
  List<ToDoItem> _list = [];
  int _filterBy = 1;
  int get filterBy => _filterBy;
  List<ToDoItem> get list => _filterList(_list, _filterBy);

  get value => null;

  Future getList() async {
    List<ToDoItem> list = await Api.getTodos();
    _list = list;
    notifyListeners();
  }

//lägger till i listan
  void addTask(task) {
    _list.add(task);
    notifyListeners();
  }

//tar bort från listan
  void removeTask(task) {
    _list.remove(task);
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
