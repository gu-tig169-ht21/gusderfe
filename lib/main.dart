import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_list_view.dart';
import 'todo_list_state.dart';

void main() async {
  var state = MyState();
  await state.getList();
  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TodolistView(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
