import 'package:flutter/material.dart';

enum TypeSnackBar { error, success }

class MySnackBar {
  MySnackBar({required this.context, required this.message, this.type = TypeSnackBar.success});

  final BuildContext context;
  final String message;
  final TypeSnackBar type;

  showSnackBar() {
    Color color = Colors.white;
    IconData icon = Icons.adb;

    switch (type) {
      case TypeSnackBar.error:
        color = Colors.red;
        icon = Icons.error;
        break;
      case TypeSnackBar.success:
        color = Colors.green;
        icon = Icons.check;
        break;
    }

    var snackBar = SnackBar(
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(icon),
          ),
          Text(message),
        ],
      ),
      backgroundColor: color,
      width: (message.length as double) + 200,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
