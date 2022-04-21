import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum TypeSnackBar { error, success }

void showSnackBar(BuildContext context, {TypeSnackBar type = TypeSnackBar.success, String message = "", DioError? error}) {
  _MySnackBar snackBar;

  _MySnackBar getSnackBar({required IconData icon, required Color color}) {
    return _MySnackBar(icon: icon, message: message, color: color);
  }

  if (error != null) {
    type = TypeSnackBar.error;
    message = error.response?.data["message"] ?? "Error de Conexión";
  }

  switch (type) {
    case TypeSnackBar.error:
      snackBar = getSnackBar(icon: Icons.error, color: Colors.red);
      break;
    case TypeSnackBar.success:
      snackBar = getSnackBar(icon: Icons.check, color: Colors.green);
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class _MySnackBar extends SnackBar {
  _MySnackBar({required IconData icon, String message = "", required Color color})
      : super(
            content: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(icon),
                ),
                Text(message),
              ],
            ),
            backgroundColor: color);
}
