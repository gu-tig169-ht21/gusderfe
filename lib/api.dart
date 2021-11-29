import 'dart:convert';
import 'package:http/http.dart' as http;
import 'todo_list_state.dart';

const API_KEY = 'f5ba4293-e01d-4e5b-a210-3e3c06e948cc';
//En variabel för hela API-key
const API_URL = 'https://todoapp-api-pyq5q.ondigitalocean.app';
//En variabel för hela URL:n

//lägger till en todo
class Api {
  static Future<List<ToDoItem>> addTask(ToDoItem task) async {
    Map<String, dynamic> json = ToDoItem.toJson(task);
    var bodyString = jsonEncode({
      'title': task.toDoText,
      'done': task.isDone,
    });
    var response = await http.post(
      Uri.parse('$API_URL/todos/?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

//tar bort en todo
  static Future deleteTask(ToDoItem task) async {
    var response = await http.delete(
        Uri.parse('$API_URL/todos/${task.id}?key=$API_KEY&_confirm=true'));
    var bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

  static Future updateTask(ToDoItem task, ToDoItem taskId) async {
    var response =
        await http.put(Uri.parse('$API_URL/todos/${task.id}?key=$API_KEY'));
    var bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

  static Future<List<ToDoItem>> getTasks() async {
    var response = await http.get(Uri.parse('$API_URL/todos?key=$API_KEY'));
    String bodyString = response.body;
    var json = jsonDecode(bodyString);

    return json.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }
}
