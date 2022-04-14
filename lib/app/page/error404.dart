import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gmt/app/page/login.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class Error404 extends StatelessWidget {
  const Error404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    return Observer(builder: (_) {
      if (session.isInSession) {
        return Material(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Center(
              child: ListView(
                children: [
                  const Icon(
                    Icons.mood_bad_sharp,
                    size: 200,
                  ),
                  const Text(
                    "Error 404",
                    textAlign: TextAlign.center,
                    textScaleFactor: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: SizedBox(
                        width: 500,
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    context.vRouter.historyBack();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.blue,
                                  ),
                                  tooltip: "Regresar",
                                  splashRadius: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    VRouter.of(context).to("/");
                                  },
                                  icon: const Icon(
                                    Icons.home,
                                    color: Colors.blue,
                                  ),
                                  tooltip: "Inicio",
                                  splashRadius: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return Login();
    });
  }
}
