import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmt/app/component/frame.dart';
import 'package:gmt/app/page/error404.dart';
import 'package:gmt/app/page/home.dart';
import 'package:gmt/app/page/local.dart';
import 'package:gmt/app/page/option.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class App extends HookWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    useEffect(() {
      session.init();
      return null;
    }, []);

    return VRouter(title: "GMT", debugShowCheckedModeBanner: false, transitionDuration: const Duration(milliseconds: 0), initialUrl: "/", routes: [
      VPopHandler(
          onSystemPop: (vRedirector) async {
            if (vRedirector.historyCanBack()) vRedirector.historyBack();
          },
          stackedRoutes: [
            VWidget(path: "/", widget: Frame(child: HomePage())),
            VWidget(path: "/home", widget: Frame(child: HomePage())),
            VWidget(path: "/local", widget: Frame(child: LocalPage())),
            VWidget(path: "/options", widget: Frame(child: OptionPage())),
            VWidget(path: "/unknown", widget: Error404Page()),
            VRouteRedirector(path: "*", redirectTo: "/unknown")
          ]),
    ]);
  }
}
