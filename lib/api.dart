import 'dart:convert';
import 'package:http/http.dart' as http;
import 'todo_list_state.dart';

const API_KEY =
    'ca3084de-4424-4421-98af-0ae9e2cb3ee5'; //En variabel för hela API-key
const API_URL =
    'https://todoapp-api-pyq5q.ondigitalocean.app'; //En variabel för hela URL:n

class Api {
//lägger till en todo
  static Future<List<ToDoItem>> addTask(ToDoItem task) async {
    Map<String, dynamic> json = ToDoItem.toJson(task);
    var bodyString = jsonEncode(json);
    var response = await http.post(
      Uri.parse('$API_URL/todos?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

  static Future deleteTask(String taskId) async {
    var response = await http
        .delete(Uri.parse('$API_URL/todos/$taskId?key=$API_KEY&_confirm=true'));
    var bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

  static Future<List<ToDoItem>> getTasks() async {
    var response = await http.get(Uri.parse('$API_URL/todos?key=$API_KEY'));
    String bodyString = response.body;
    print(bodyString);
    var json = jsonDecode(bodyString);

    return json.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }
}
