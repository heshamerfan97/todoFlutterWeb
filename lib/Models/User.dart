import 'dart:io';

import 'package:flutter/cupertino.dart';

class User {
  int id;
  String name, imagePath;
  FileImage image;

  User({
    this.id = -1,
    this.name = 'Guest',
    this.imagePath,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    imagePath: json['imagePath'],
    image: json['imagePath']==null? null : FileImage(File(json['imagePath'])),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imagePath': imagePath,
  };

}