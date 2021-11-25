import 'dart:convert';
import 'package:http/http.dart' as http;
import 'todo_list_state.dart';

const API_KEY =
    'b7b957c4-9495-4ea1-ba1e-f8159a495c4b'; //En variabel för hela API-key
const API_URL =
    'https://todoapp-api-pyq5q.ondigitalocean.app'; //En variabel för hela URL:n

//lägger till en todo
class Api {
  static Future<List<ToDoItem>> addTask(ToDoItem task) async {
    Map<String, dynamic> json = ToDoItem.toJson(task);
    var bodyString = jsonEncode({
      'title': task.toDoText,
    });
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

//tar bort en todo
  static Future deleteTask(String taskId) async {
    var response = await http
        .delete(Uri.parse('$API_URL/todos/$taskId?key=$API_KEY&_confirm=true'));
    var bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

  static Future changeTask(String taskId) async {
    var response = await http
        .put(Uri.parse('$API_URL/todos/$taskId?key=$API_KEY&_confirm=true'));
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
