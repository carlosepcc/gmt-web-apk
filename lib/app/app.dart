import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmt/app/component/frame.dart';
import 'package:gmt/app/page/error404.dart';
import 'package:gmt/app/page/home.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class App extends HookWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    useEffect(() {
      session.init();
      return () {};
    }, []);

    return VRouter(title: "GMT", debugShowCheckedModeBanner: false, transitionDuration: const Duration(milliseconds: 0), initialUrl: "/", routes: [
      VPopHandler(
          onSystemPop: (vRedirector) async {
            if (vRedirector.historyCanBack()) vRedirector.historyBack();
          },
          stackedRoutes: [
            VWidget(path: "/", widget: const Frame(child: Home())),
            VWidget(path: "/home", widget: const Frame(child: Home())),
            VWidget(path: "/unknown", widget: const Error404()),
            VRouteRedirector(path: "*", redirectTo: "/unknown")
          ]),
    ]);
  }
}
