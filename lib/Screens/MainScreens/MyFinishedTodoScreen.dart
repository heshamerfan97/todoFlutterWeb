import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/TODO/todo_bloc.dart';
import 'package:my_todo_list/Models/TODO.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';
import 'package:my_todo_list/Widgets/TodoWidget.dart';

// ignore: must_be_immutable
class MyFinishedTodoScreen extends StatelessWidget {
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state is TodoLoaded) todoList = state.toDos;
        if (state is TodoRemoved) todoList.remove(state.todo);
        if(state is TodoAdded && todoList.where((todo) => todo.done).toList().isEmpty)
          AppBloc.toDoBloc.add(OnTodoLoad());
        return RefreshIndicator(
          onRefresh: () async {
            AppBloc.toDoBloc.add(OnTodoLoad());
          },
          child: todoList.where((todo) => todo.done).toList().length > 0
        ? SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            primary: true,
            child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Great work, these todos has been done',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.headline6,
                          )),
                      ...todoList
                          .where((todo) => todo.done)
                          .toList()
                          .map((todo) => TodoWidget(todo,
                              ValueKey(DateTime.now().toString() + todo.id)))
                          .toList(),
                    ]
                  )

          ) : Center(
        child: Text(LanguageRepository.translate(context,
            'You did not finish any of your tasks, work harder to gain more')),
        ),
        );
      }),
    );
  }
}
