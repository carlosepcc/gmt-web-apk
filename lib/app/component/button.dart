import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddButton extends HookWidget {
  const AddButton({Key? key, this.onPressed, this.popNavigator = false}) : super(key: key);

  final bool popNavigator;
  final Future<bool> Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final circularIndicador = useState(false);

    VoidCallback? getFunction() {
      if (circularIndicador.value) {
        return null;
      }
      if (onPressed != null) {
        return () {
          onPressed!().then((value) {
            if (value) circularIndicador.value = false;
            if (popNavigator) Navigator.of(context).pop();
          });
          circularIndicador.value = true;
        };
      }
      return null;
    }

    return ElevatedButton(
      onPressed: getFunction(),
      child: !circularIndicador.value
          ? Text("Aceptar")
          : SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              )),
    );
  }
}
