import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  InputPassword({Key? key, this.onChange, this.onEnterPress}) : super(key: key);

  final Function(InputData inputData)? onChange;
  final VoidCallback? onEnterPress;

  @override
  Widget build(BuildContext context) {
    final showPassword = useState<bool>(true);
    final error = useState<InputError>(InputError(message: "No puede estar vacío"));

    void validate(String value) {
      if (value.isEmpty) {
        error.value = InputError(message: "No puede estar vacío");
      } else if (value.length < 4) {
        error.value = InputError(message: "Tamaño no valido");
      } else {
        error.value = InputError();
      }
      onChange!(InputData(value: value, error: error.value.isInError()));
    }

    return TextFormField(
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
      onFieldSubmitted: (text) {
        if (onEnterPress != null) onEnterPress!();
      },
    );
  }
}

class InputUsername extends HookWidget {
  InputUsername({Key? key, this.onChange, this.onEnterPress}) : super(key: key);

  final Function(InputData inputData)? onChange;
  final VoidCallback? onEnterPress;

  @override
  Widget build(BuildContext context) {
    final error = useState<InputError>(InputError(message: "No puede estar vacío"));

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
      onChange!(InputData(value: value, error: error.value.isInError()));
    }

    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(labelText: "Usuario", errorText: error.value.message),
      onChanged: validate,
      onFieldSubmitted: (text) {
        if (onEnterPress != null) onEnterPress!();
      },
    );
  }
}

class InputNumber extends HookWidget {
  InputNumber({Key? key, this.onChange, this.onEnterPress, this.defaultValue, this.error = false}) : super(key: key);

  final Function(InputData inputData)? onChange;
  final VoidCallback? onEnterPress;
  final String? defaultValue;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final error = useState<InputError>(InputError(message: this.error ? "No puede estar vacío" : null));

    void validate(String value) {
      if (value.isEmpty) {
        error.value = InputError(message: "No puede estar vacío");
      } else if (int.parse(value[0]) == 0) {
        error.value = InputError(message: "No puede empezar por cero");
      } else {
        error.value = InputError();
      }
      if (onChange != null) onChange!(InputData(value: value, error: error.value.isInError()));
    }

    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Numero", errorText: error.value.message),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: validate,
      initialValue: defaultValue,
      onFieldSubmitted: (text) {
        if (onEnterPress != null) onEnterPress!();
      },
    );
  }
}

RegExp _lettersUppercase = RegExp("[A-Z]");
RegExp _specialCharacters = RegExp("[!@#\$&*~. ]");
RegExp _numbers = RegExp("[0-9]");
