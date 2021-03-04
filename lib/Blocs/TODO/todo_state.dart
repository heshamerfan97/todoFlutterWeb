part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> toDos;

  TodoLoaded({this.toDos});
}

class TodoAdded extends TodoState {
  final Todo todo;

  TodoAdded({this.todo});
}

class TodoRemoved extends TodoState {
  final Todo todo;

  TodoRemoved({this.todo});
}

class TodoError extends TodoState {}
