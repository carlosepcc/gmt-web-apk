import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmt/app/store/float_button_store/float_button_store.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:provider/provider.dart';

class OptionPage extends HookWidget {
  const OptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var session = Provider.of<Session>(context);
    final floatButtonStore = Provider.of<FloatButtonStore>(context);

    useEffect(() {
      floatButtonStore.state = FloatButtonState.none;
      return null;
    }, []);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: CircleAvatar(
                minRadius: 50,
                child: Text(session.username[0].toUpperCase(), style: TextStyle(fontSize: 80)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Center(child: Text(session.username, style: TextStyle(fontSize: 20))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    color: Colors.grey[200],
                    child: ListTile(
                      title: Text("Salir"),
                      leading: Icon(Icons.logout),
                      hoverColor: Colors.grey[500],
                      onTap: () {
                        session.logout();
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
