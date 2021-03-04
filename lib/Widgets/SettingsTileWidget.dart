import 'package:flutter/material.dart';
import 'package:my_todo_list/Models/User.dart';

// ignore: must_be_immutable
class SettingsTileWidget extends StatelessWidget {
  final String title, routeName;
  final IconData icon;
  final User user;
  Function toDo;

  SettingsTileWidget({
    @required this.title,
    @required this.routeName,
    @required this.icon,
    @required this.user,
    this.toDo,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      child: ListTile(
        onTap: routeName == null
            ? () {}
            : () {
          if(toDo != null)
            toDo();
          Navigator.of(context).pushNamed(routeName, arguments: user);
        },
        dense: true,
        title: Text(
          title,
          style: textTheme.headline6,
        ),
        leading: Icon(icon),
        trailing: Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: colors.primaryColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.arrow_forward,
            color: colors.primaryColor,
            size: 14,
          ),
        ),
      ),
    );
  }
}