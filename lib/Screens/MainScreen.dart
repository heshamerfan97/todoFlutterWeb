import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';
import 'package:my_todo_list/Screens/MainScreens/MainScreens.dart';
import 'package:my_todo_list/Utils/Routes.dart';

class MainScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    bool darkModeOn = brightness == Brightness.dark;
    return Directionality(
      textDirection:
    Application.isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: LanguageRepository.translate(context, 'Todo'),
                ),
                Tab(
                  text: 'Grid',
                ),
                Tab(
                  text: LanguageRepository.translate(context, 'Done'),
                )
              ],
            ),
            title: Text(LanguageRepository.translate(context, 'My Todo')),
            actions: [
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () => Navigator.of(context).pushNamed(
                        Routes.MAIN_SETTINGS,
                      )),
            ],
          ),
          body: TabBarView(
            children: [
              /*Stack(
                children: [
                  Positioned.fill(
                    child:
                        *//*BlocListener<TodoBloc, TodoState>(
                      listener: (context, state) {
                        if (state is TodoLoaded) toDoList = state.toDos;
                        if (state is TodoAdded) {
                          {
                            toDoList.add(state.todo);
                            print('Length: ${toDoList.length}');
                            _myListKey.currentState.insertItem(
                                toDoList.indexWhere((toDO) => toDO == state.todo));
                          }
                        }
                        if (state is TodoRemoved) {
                          final index =
                              toDoList.indexWhere((todo) => todo == state.todo);
                          _myListKey.currentState.removeItem(
                              index, (ctx, animation) => TODOWidget(toDoList[index]));
                          toDoList.remove(state.todo);
                        }
                      },
                      child: *//*

                    *//*),*//*
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
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
              ),*/
              MyTodoScreen(darkModeOn),
              MyTodoGridScreen(darkModeOn),
              MyFinishedTodoScreen(),
            ],
          ),
        ),
      ),
    );
  }


}
