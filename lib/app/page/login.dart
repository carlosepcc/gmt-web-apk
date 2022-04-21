import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    var circularProgressIndicator = useState<bool>(false);

    submit() {
      if (!username.value.error && !password.value.error) {
        return () {
          session.login(username: username.value.value, password: password.value.value, context: context).then((value) {
            if (!value) circularProgressIndicator.value = false;
          });
          circularProgressIndicator.value = true;
        };
      }
      return null;
    }

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
                      child: InputUsername(
                        onChange: (data) => username.value = data,
                      )),
                  Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: InputPassword(onChange: (data) => password.value = data, onEnterPress: submit())),
                  Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                    child: ElevatedButton(
                        onPressed: !circularProgressIndicator.value ? submit() : null,
                        child: !circularProgressIndicator.value
                            ? Text("Entrar")
                            : SizedBox(
                                height: 23,
                                width: 23,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ))),
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
