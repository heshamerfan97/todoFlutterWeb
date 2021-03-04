import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Models/TODO.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';

class TodoGridWidget extends StatelessWidget {
  /*final AnimationController animationController;
  final Animation<dynamic> animation;*/
  final Todo todo;
  final bool darkModeOn;
  final Key key;

  const TodoGridWidget(
      {this.key,
      this.todo,
      this.darkModeOn /*, this.animationController, this.animation*/
      });

  @override
  Widget build(BuildContext context) {
    return /*AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: */
        SizedBox(
          key: key,
      width: 160,
      height: 250,
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xFF563879).withOpacity(0.6),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
                gradient: LinearGradient(
                  colors: <Color>[
                    if(todo.color == 0) Color(0xFF522855),
                    if(todo.color == 0) Color(0xFF505888),
                    if(todo.color != 0) Color(todo.color - 64),
                    if(todo.color != 0) Color(todo.color + 64),
                  ],
                  begin: Application.isEnglish ? Alignment.topLeft : Alignment.topRight,
                  end: Application.isEnglish ? Alignment.bottomRight : Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(Application.isEnglish ? 8.0 : 54.0),
                  topRight: Radius.circular(Application.isEnglish ? 54.0 : 8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 54, left: 16, right: 16, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      todo.title,
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(todo.description),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit_outlined),
                            onPressed: () => _showEditDialog(context)),
                        Checkbox(
                          value: todo.done,
                          onChanged: (value) => !todo.done
                              ? AppBloc.toDoBloc.add(OnTodoDone(todo: todo))
                              : AppBloc.toDoBloc.add(OnTodoUnDone(todo: todo)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: Application.isEnglish ? 0 : null,
            right: Application.isEnglish ? null : 0,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: (AppTheme.darkThemeOption == DarkOption.Dynamic
                        ? (darkModeOn ? Colors.black : Colors.white)
                        : (AppTheme.darkThemeOption == DarkOption.AlwaysOn
                            ? Colors.black
                            : Colors.white))
                    .withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 7.5,
            left: Application.isEnglish ? 7.5 : null,
            right: Application.isEnglish ? null : 7.5,
            child: SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(todo.icon),
            ),
          )
        ],
      ),
    ) /*,
          ),
        );
      },
    )*/
        ;
  }

  _showEditDialog(BuildContext context) {
    print('ID: ${todo.id}');
    TextEditingController titleController =
        TextEditingController(text: todo.title);
    TextEditingController descriptionController =
        TextEditingController(text: todo.description);
    showDialog(
        context: context,
        builder: (ctx) => Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Material(
              color: AppTheme.currentTheme.color,
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: titleController,
                              decoration: InputDecoration(
                                hintText: LanguageRepository.translate(
                                    context, 'New todo'),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                              cursorColor: Colors.white,
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.delete_outline),
                              onPressed: () {
                                Navigator.of(context).pop();
                                AppBloc.toDoBloc.add(OnTodoDelete(todo: todo));
                              })
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.25,
                        endIndent: 50,
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: LanguageRepository.translate(
                              context, 'Write a note'),
                          hintStyle: TextStyle(fontSize: 22),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 22),
                        cursorColor: Colors.white,
                        maxLines: 6,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.25,
                      ),
                      TextButton(
                        onPressed: () => _editTodo(
                            context: context,
                            title: titleController.text,
                            description: descriptionController.text),
                        child: Text(
                          LanguageRepository.translate(context, 'Save'),
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  _editTodo({BuildContext context, String title, String description}) {
    Todo _todo = new Todo(
      id: todo.id,
      title: title,
      description: description,
      creationDate: todo.creationDate,
      lastEditDate: DateTime.now(),
      done: todo.done,
    );
    AppBloc.toDoBloc.add(OnTodoEdit(todo: _todo));
    Navigator.of(context).pop();
  }
}
