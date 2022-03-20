import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gmt/app/component/app_bar.dart';
import 'package:provider/provider.dart';

import '../page/login.dart';
import '../store/session/session.dart';

class Frame extends StatelessWidget {
  const Frame({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    return Material(
      child: Observer(builder: (_) {
        if (session.isInSession) {
          return Scaffold(
            appBar: MyAppBar(session),
            body: child,
          );
        } else {
          return const Login();
        }
      }),
    );
  }
}
