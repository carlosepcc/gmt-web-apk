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
  InputPassword({Key? key, required this.controller}) : super(key: key);

  final ValueNotifier<InputData> controller;

  final showPassword = useState<bool>(true);
  final error = useState<InputError>(InputError(message: "No puede estar vacío"));

  @override
  Widget build(BuildContext context) {
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
      onChanged: validate,
    );
  }

  void validate(String value) {
    if (value.isEmpty) {
      error.value = InputError(message: "No puede estar vacío");
    } else if (value.length < 4) {
      error.value = InputError(message: "Tamaño no valido");
    } else {
      error.value = InputError();
    }
    controller.value = InputData(value: value, error: error.value.isInError());
  }
}

class InputUsername extends HookWidget {
  InputUsername({Key? key, required this.controller}) : super(key: key);

  final ValueNotifier<InputData> controller;

  final error = useState<InputError>(InputError(message: "No puede estar vacío"));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.name, decoration: InputDecoration(labelText: "Usuario", errorText: error.value.message), onChanged: validate);
  }

  void validate(String value) {
    if (value.isEmpty) {
      error.value = InputError(message: "No puede estar vacío");
    } else if (_numbers.hasMatch(value[0])) {
      error.value = InputError(message: "No puede comenzar con un numero");
    } else if (_lettersUppercase.hasMatch(value)) {
      error.value = InputError(message: "No puede contener mayúsculas");
    } else if (value.length < 4) {
      error.value = InputError(message: "Tamaño no valido");
    } else if (_specialCharacters.hasMatch(value)) {
      error.value = InputError(message: "Contiene letras no valido");
    } else {
      error.value = InputError();
    }
    controller.value = InputData(value: value, error: error.value.isInError());
  }
}

RegExp _lettersUppercase = RegExp("[A-Z]");
RegExp _specialCharacters = RegExp("[!@#\$&*~. ]");
RegExp _numbers = RegExp("[0-9]");
