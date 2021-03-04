import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Models/TODO.dart';
import 'package:my_todo_list/Repositories/TodoRepository.dart';
import 'package:my_todo_list/Utils/CustomRectTween.dart';
import 'package:my_todo_list/Utils/HeroDialogRoute.dart';
import 'package:my_todo_list/Widgets/AddTodoPopUpCard.dart';
import 'package:my_todo_list/Widgets/MyRefreshableReorderableListView.dart';
import 'package:my_todo_list/Widgets/TodoWidget.dart';
import 'package:my_todo_list/Configurations/Animation.dart' as animation;

// ignore: must_be_immutable
class MyTodoScreen extends StatelessWidget {
  final bool darkModeOn;
  List<Todo> todoList = [];
  TodoRepository todoRepository = TodoRepository();

  MyTodoScreen(this.darkModeOn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        print('Build');
        if (state is TodoLoaded) {
          print('Load');
          todoList = state.toDos;
        }
        if (state is TodoRemoved) {
          print('Remove');
          todoList.remove(state.todo);
        }
        return Stack(
          children: [
            SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  AppBloc.toDoBloc.add(OnTodoLoad());
                },
                child: MyRefreshableReorderableListView(
                  onReorder: _reorderList,
                  //scrollController: _listScrollController,
                  children: [
                    for (final todo
                        in todoList.where((todo) => !todo.done).toList())
                      TodoWidget(
                          todo, ValueKey(DateTime.now().toString() + todo.id)),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: Application.isEnglish ? null : 0,
              left: Application.isEnglish ? 0 : null,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(HeroDialogRoute(
                      builder: (context) => AddTodoPopUpCard(),
                    ));
                  },
                  child: Hero(
                    tag: animation.Animation.ADD_TODO_HERO_ANIMATION,
                    createRectTween: (begin, end) {
                      return CustomRectTween(begin: begin, end: end);
                    },
                    child: Material(
                      color: AppTheme.currentTheme.color,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.add_rounded,
                          size: 40,
                          color: AppTheme.darkThemeOption == DarkOption.Dynamic
                              ? (darkModeOn ? Colors.white : Colors.black)
                              : (AppTheme.darkThemeOption == DarkOption.AlwaysOn
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _reorderList(int oldIndex, int newIndex) {
    print('list reordered, OldIndex: $oldIndex, newIndex:$newIndex');
    Todo todo = todoList[oldIndex];
    todoList.removeAt(oldIndex);
    todoList.insert(oldIndex > newIndex ? newIndex : newIndex - 1, todo);
    //_listScrollController.jumpTo(0.0);
    todoRepository.saveTodoList(todoList);
    AppBloc.toDoBloc.add(OnTodoLoad());
  }
}
