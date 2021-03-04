import 'package:my_todo_list/Configurations/Images.dart';

class Todo {
  final String id, title, description, icon;
  final DateTime creationDate, lastEditDate;
  final int color;
  bool done;

  Todo({
    this.id,
    this.title,
    this.description,
    this.icon,
    this.creationDate,
    this.lastEditDate,
    this.color,
    this.done,
  });

  factory Todo.fromJson(Map<String, dynamic> json)=> Todo(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    icon: json['icon']??Images.asset0,
    creationDate: DateTime.parse(json['creationDate']),
    lastEditDate: json['lastEditDate']==null?null:DateTime.parse(json['lastEditDate']),
    color: json['color']??0,
    done: json['done'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'icon': icon,
    'creationDate': creationDate.toIso8601String(),
    'lastEditDate': lastEditDate==null?null:lastEditDate.toIso8601String(),
    'color': color,
    'done': done,
  };
}