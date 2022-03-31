import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmt/app/component/input.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:provider/provider.dart';

class Login extends HookWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);

    var username = useState<InputData>(InputData(error: true));
    var password = useState<InputData>(InputData(error: true));

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
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      margin: const EdgeInsets.only(top: 30, bottom: 5),
                      child: InputUsername(
                        controller: username,
                      )),
                  Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: InputPassword(
                        controller: password,
                        onEnterPress: !username.value.error && !password.value.error
                            ? () => session.login(username: username.value.value, password: password.value.value, context: context)
                            : null,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
                    child: ElevatedButton(
                        onPressed: !username.value.error && !password.value.error
                            ? () => session.login(username: username.value.value, password: password.value.value, context: context)
                            : null,
                        child: const Text("Entrar")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
