import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InputError {
  String? message;

  InputError({this.message});

  bool isInError() => message != null;
}

class InputData {
  String value;
  bool error;

  InputData({this.value = "", this.error = false});
}

class InputPassword extends HookWidget {
  const InputPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final ValueNotifier<InputData> controller;

  @override
  Widget build(BuildContext context) {
    var showPassword = useState<bool>(true);
    var error = useState<InputError>(InputError(message: "No puede estar vacío"));

    return TextField(
      obscureText: showPassword.value,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: "Contraseña",
        errorText: error.value.message,
        suffixIcon: IconButton(
            icon: Icon(
              showPassword.value ? Icons.visibility : Icons.visibility_off,
            ),
            tooltip: showPassword.value ? "Mostar Contraseña" : "Ocultar Contraseña",
            splashRadius: 20,
            onPressed: () {
              showPassword.value = !showPassword.value;
            }),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          error.value = InputError(message: "No puede estar vacío");
        } else {
          error.value = InputError();
        }
        controller.value = InputData(value: value, error: error.value.isInError());
      },
    );
  }
}

class InputUsername extends HookWidget {
  const InputUsername({Key? key, required this.controller}) : super(key: key);
  final ValueNotifier<InputData> controller;

  @override
  Widget build(BuildContext context) {
    var error = useState<InputError>(InputError(message: "No puede estar vacío"));

    return TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(labelText: "Usuario", errorText: error.value.message),
        onChanged: (value) {
          if (value.isEmpty) {
            error.value = InputError(message: "No puede estar vacío");
          } else {
            error.value = InputError();
          }
          controller.value = InputData(value: value, error: error.value.isInError());
        });
  }
}
