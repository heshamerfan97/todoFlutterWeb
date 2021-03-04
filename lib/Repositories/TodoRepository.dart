import 'dart:convert';

import 'package:my_todo_list/Configurations/Preferences.dart';
import 'package:my_todo_list/Models/TODO.dart';
import 'package:my_todo_list/Utils/PreferencesUtils.dart';

class TodoRepository{

  Future<void> saveTodoList(List<Todo> todoList) async{
    await PreferencesUtils.setString(Preferences.toDos, json.encode(todoList.map((todo) => todo.toJson()).toList()));
    print('saved');
  }

  List<Todo> getTodoList(){
    List<Todo> todoList = [];
    final _todoList = PreferencesUtils.getString(Preferences.toDos);
    print('ToDOS: $_todoList');
    if(_todoList != null){
      final decryptedToDos = json.decode(_todoList) as List<dynamic>;
      decryptedToDos.forEach((todo) => todoList.add(Todo.fromJson(todo)));
    }
    print('ToDOS2: $todoList');
    return todoList;
  }
}