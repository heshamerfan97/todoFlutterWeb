part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class OnTodoLoad extends TodoEvent {}

class OnTodoAdd extends TodoEvent {
  final Todo todo;

  OnTodoAdd({this.todo});
}

class OnTodoDelete extends TodoEvent {
  final Todo todo;

  OnTodoDelete({this.todo});
}

class OnTodoDone extends TodoEvent {
  final Todo todo;

  OnTodoDone({this.todo});
}

class OnTodoUnDone extends TodoEvent {
  final Todo todo;

  OnTodoUnDone({this.todo});
}

class OnTodoEdit extends TodoEvent {
  final Todo todo;

  OnTodoEdit({this.todo});
}