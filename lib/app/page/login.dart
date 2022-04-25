import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmt/app/component/button.dart';
import 'package:gmt/app/component/input.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:provider/provider.dart';

class Login extends HookWidget {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    var username = useState<InputData>(InputData(error: true));
    var password = useState<InputData>(InputData(error: true));
    var circularIndicador = useState<bool>(false);

    bool valid = username.value.error || password.value.error;

    onEnter() => () {
          if (!valid) {
            circularIndicador.value = true;
            session
                .login(username: username.value.value, password: password.value.value, context: context)()
                .then((value) => circularIndicador.value = false);
          }
        };

    return Scaffold(
      body: SizedBox(
        height: 500,
        child: Center(
          child: SizedBox(
            width: 400,
            height: 300,
            child: Card(
              elevation: 3,
              child: ListView(
                children: [
                  Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      margin: EdgeInsets.only(top: 30, bottom: 5),
                      child: InputUsername(onChange: (data) => username.value = data, onEnterPress: onEnter())),
                  Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: InputPassword(
                        onChange: (data) => password.value = data,
                        onEnterPress: onEnter(),
                      )),
                  Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                      child: !circularIndicador.value
                          ? AddButton(
                              onPressed:
                                  valid ? null : session.login(username: username.value.value, password: password.value.value, context: context),
                            )
                          : SizedBox(
                              child: AddButton(
                                circularIndicador: true,
                              ),
                            ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
