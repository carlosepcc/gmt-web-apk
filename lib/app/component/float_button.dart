import 'package:flutter/material.dart';
import 'package:gmt/app/store/float_button_store/float_button_store.dart';
import 'package:provider/provider.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonState = Provider.of<FloatButtonStore>(context);
    switch (buttonState.state) {
      case (FloatButtonState.add):
        return FloatingActionButton(
          onPressed: buttonState.action,
          child: Tooltip(message: "Añadir", child: Icon(Icons.add)),
        );
      case (FloatButtonState.update):
        return FloatingActionButton(
          onPressed: buttonState.action,
          backgroundColor: Colors.grey,
          child: Tooltip(message: "Modificar", child: Icon(Icons.update)),
        );
      default:
        return FloatingActionButton(
          onPressed: null,
        );
    }
  }
}
