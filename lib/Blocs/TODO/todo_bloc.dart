import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Models/TODO.dart';
import 'package:my_todo_list/Repositories/TodoRepository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial());

  TodoRepository todoRepository = TodoRepository();
  List<Todo> todoList = [];

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is OnTodoLoad) {
      todoList = todoRepository.getTodoList();
      yield TodoLoaded(toDos: todoList);
      todoRepository.saveTodoList(todoList);
    }
    if (event is OnTodoAdd) {
      todoList.add(event.todo);
      await todoRepository.saveTodoList(todoList);
      yield TodoAdded(todo: event.todo);
    }
    if (event is OnTodoDelete) {
      todoList.remove(event.todo);
      await todoRepository.saveTodoList(todoList);
      yield TodoRemoved(todo: event.todo);
    }
    if (event is OnTodoDone) {
      todoList.remove(event.todo);
      yield TodoRemoved(todo: event.todo);
      event.todo.done = true;
      todoList.add(event.todo);
      yield TodoAdded(todo: event.todo);
      await todoRepository.saveTodoList(todoList);
    }
    if (event is OnTodoUnDone) {
      todoList.remove(event.todo);
      yield TodoRemoved(todo: event.todo);
      event.todo.done = false;
      todoList.add(event.todo);
      yield TodoAdded(todo: event.todo);
      await todoRepository.saveTodoList(todoList);
    }
    if (event is OnTodoEdit) {
      print(event.todo.title);
      print(event.todo.description);
      final todoIndex = todoList.indexWhere((todo) => todo.id == event.todo.id);
      print(todoIndex);
      if (todoIndex != -1) todoList[todoIndex] = event.todo;
      await todoRepository.saveTodoList(todoList);
      AppBloc.toDoBloc.add(OnTodoLoad());
    }
  }
}
