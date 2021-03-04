import 'package:flutter/material.dart';
import 'package:my_todo_list/AppBloc.dart';
import 'package:my_todo_list/Blocs/Blocs.dart';
import 'package:my_todo_list/Configurations/Theme.dart';
import 'package:my_todo_list/Models/TODO.dart';
import 'package:my_todo_list/Repositories/LanguageRepository.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final Key key;

  TodoWidget(this.todo, this.key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: (DismissDirection dismissDirection) {
        if(dismissDirection == DismissDirection.endToStart)
          AppBloc.toDoBloc.add(OnTodoDelete(todo: todo));
        else if(dismissDirection == DismissDirection.startToEnd)
          _showEditDialog(context);
      },
      secondaryBackground: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: Icon(Icons.delete_outline),
        alignment: Alignment.centerRight,
        height: 70,
        width: double.infinity,
      ),
      background: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(5),decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).accentColor,
      ),
        child: Icon(Icons.edit_outlined),
        alignment: Alignment.centerLeft,
        height: 70,
        width: double.infinity,
      ),
      child: Card(
        child: ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
                decoration: todo.done ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(todo.description),
          dense: false,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: Icon(Icons.edit_outlined), onPressed: () => _showEditDialog(context)),
              Checkbox(
                value: todo.done,
                onChanged: (value) => !todo.done
                    ? AppBloc.toDoBloc.add(OnTodoDone(todo: todo))
                    : AppBloc.toDoBloc.add(OnTodoUnDone(todo: todo)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showEditDialog(BuildContext context){
    print('ID: ${todo.id}');
    TextEditingController titleController = TextEditingController(text: todo.title);
    TextEditingController descriptionController = TextEditingController(text: todo.description);
    showDialog(context: context, builder: (ctx) =>Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Material(
            color: AppTheme.currentTheme.color,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
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
                              hintText: LanguageRepository.translate(context, 'New todo'),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                            cursorColor: Colors.white,
                          ),
                        ),
                        IconButton(icon: Icon(Icons.delete_outline), onPressed: (){
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
                    TextButton(
                      onPressed: () => _editTodo(context: context, title: titleController.text, description: descriptionController.text),
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

  _editTodo({BuildContext context, String title, String description}){
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
