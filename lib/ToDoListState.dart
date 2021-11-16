import 'package:flutter/material.dart';

class TodoListState extends ChangeNotifier {
  final List _list = [];

  List get list => _list;

  void addListItem(item) {
    _list.add(item);
    notifyListeners();
  }

  void removeListItem(index) {
    _list.removeAt(index);
    notifyListeners();
  }
}
