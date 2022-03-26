import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gmt/app/component/app_bar.dart';
import 'package:provider/provider.dart';

import '../page/login.dart';
import '../store/session/session.dart';

enum TyPeAppBar { vertical, horizontal }

class Frame extends HookWidget {
  Frame({Key? key, required this.child}) : super(key: key);
  final Widget child;

  final typeAppBar = useState<TyPeAppBar>(TyPeAppBar.vertical);

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    return Material(
      child: Observer(builder: (_) {
        if (session.isInSession) {
          return Scaffold(
              appBar: typeAppBar.value == TyPeAppBar.horizontal ? AppBarHorizontal(session) : null,
              body: Row(
                children: children([child]),
              ));
        } else {
          return const Login();
        }
      }),
    );
  }

  List<Widget> children(List<Widget> children) {
    if (typeAppBar.value == TyPeAppBar.vertical) children.insert(0, const AppBarVertical());
    return children;
  }
}
