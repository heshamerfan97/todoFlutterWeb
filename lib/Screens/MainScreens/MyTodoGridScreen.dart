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
import 'package:my_todo_list/Widgets/TodoGridWidget.dart';
import 'package:my_todo_list/Configurations/Animation.dart' as animation;
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
//import 'package:reorderables/reorderables.dart';

// ignore: must_be_immutable
class MyTodoGridScreen extends StatelessWidget {
  final bool darkModeOn;
  List<Todo> todoList = [];
  TodoRepository todoRepository = TodoRepository();

  MyTodoGridScreen(this.darkModeOn);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    /// spacing = (deviceWidth - (widgetWidth * #crossAxisCount)) / 3, 3 => spaces around and in between
    final spacing = 20.0 /*(deviceWidth - (160.0*2)) / 3*/;
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoaded) todoList = state.toDos;
            if (state is TodoRemoved) todoList.remove(state.todo);
            return Stack(
              children: [
                Positioned.fill(
                  child: SafeArea(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        AppBloc.toDoBloc.add(OnTodoLoad());
                      },
                      child: /*GridView.builder(
                        padding: EdgeInsets.all(20.0),
                        itemCount: todoList.where((todo) => !todo.done).length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 40, childAspectRatio: 130/216),
                        itemBuilder: (ctx, index) => TodoGridWidget(
                          todo: todoList[index],
                          darkModeOn: darkModeOn,
                        ),
                      ),*/
                      Padding(
                              padding: EdgeInsets.symmetric(horizontal: spacing, vertical: 10),
                              child: /*ReorderableWrap(
                                onReorder: _reorderList,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                minMainAxisCount: ((deviceWidth / 160) - ((deviceWidth / 160 +1) * 20)).ceil(),
                                spacing: spacing,
                                children: todoList.where((todo) => !todo.done).map((todo) => TodoGridWidget(
                                  todo: todo,
                                  darkModeOn: darkModeOn,
                                )).toList(),
                              ),*/
                              Container(
                                key: Key(DateTime.now().toString() + '-1'),
                                child: ReorderableGridView(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: ((deviceWidth / (160 + ((deviceWidth / 160 +1) * 10)))).ceil(),
                                  shrinkWrap: true,
                                  onReorder: _reorderList,
                                  children: todoList.where((todo) => !todo.done).map((todo) => TodoGridWidget(
                                    todo: todo,
                                    darkModeOn: darkModeOn,
                                    key: ValueKey('${DateTime.now().toString()}${todo.id}'),
                                  )).toList(),
                                  childAspectRatio: 160/220,
                                ),
                              ),
                            ),


                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: Application.isEnglish ?0:null,
                  left: Application.isEnglish ?null:0,
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

  void _reorderList(int oldIndex, int newIndex) async {
    print('list reordered, OldIndex: $oldIndex, newIndex:$newIndex');
    Todo todo = todoList[oldIndex];
    todoList.removeAt(oldIndex);
    todoList.insert(newIndex, todo);
    //_listScrollController.jumpTo(0.0);
    await todoRepository.saveTodoList(todoList);
    AppBloc.toDoBloc.add(OnTodoLoad());
  }
}
