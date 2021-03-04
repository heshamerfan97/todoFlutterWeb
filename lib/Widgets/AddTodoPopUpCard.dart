import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';
import 'package:my_todo_list/Configurations/Animation.dart' as animation;
import 'package:my_todo_list/Configurations/Application.dart';
import 'package:my_todo_list/Configurations/Images.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Models/TODO.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';
import 'package:my_todo_list/Utils/CustomRectTween.dart';


class AddTodoPopUpCard extends StatefulWidget {
  @override
  _AddTodoPopUpCardState createState() => _AddTodoPopUpCardState();
}

class _AddTodoPopUpCardState extends State<AddTodoPopUpCard> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  String chosenAsset = Images.asset0;
  int chosenColor = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: animation.Animation.ADD_TODO_HERO_ANIMATION,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: chosenColor == 0? AppTheme.currentTheme.color : Color(chosenColor),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: LanguageRepository.translate(context, 'New todo'),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        cursorColor: Colors.white,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.25,
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: LanguageRepository.translate(context, 'Write a note'),
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
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: Application.TodoAssets.map((asset) => GestureDetector(
                            onTap: () {
                              setState(() {
                                chosenAsset = asset;
                              });
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: asset == chosenAsset?Theme.of(context).accentColor:Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(asset, height: 45, width: 45,),
                            ),
                          ),).toList(),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.25,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: Application.TodoColors.map(
                                (color) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  chosenColor = color;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      side: BorderSide(
                                          width: color == chosenColor ? 2 : 0,
                                          color: Theme.of(context).accentColor)),
                                  color: Color(color),
                                  elevation: color == chosenColor ? 3 : 0,
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                  ),
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.25,
                      ),
                      TextButton(
                        onPressed: () => _addNote(context),
                        child: Text(
                          LanguageRepository.translate(context, 'Add'),
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _addNote(BuildContext context) {
    AppBloc.toDoBloc.add(OnTodoAdd(
        todo: new Todo(
            id: DateTime.now().toString(),
            done: false,
            color: chosenColor,
            description: descriptionController.text,
            icon: chosenAsset,
            creationDate: DateTime.now(),
            title: titleController.text)));
      Navigator.of(context).pop();
  }
}
