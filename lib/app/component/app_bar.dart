import 'package:flutter/material.dart';
import 'package:gmt/app/store/session/session.dart';
import 'package:vrouter/vrouter.dart';

class AppBarHorizontal extends AppBar {
  AppBarHorizontal(Session session, {Key? key})
      : super(
            key: key,
            title: const Text("GMT"),
            toolbarHeight: 50,
            actions: [
              PopupMenuButton(
                  tooltip: "Opciones",
                  child: CircleAvatar(child: Text(session.username[0].toUpperCase())),
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: const Text("Salir"),
                          onTap: session.logout,
                        )
                      ])
            ],
            primary: true);
}

class AppBarVertical extends StatelessWidget {
  const AppBarVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final url = context.vRouter.url;
    return Container(
      decoration: const BoxDecoration(color: Colors.lightBlue, border: Border(right: BorderSide(width: 0.2))),
      width: 150,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 50),
            child: SelectableText(
              "GMT",
              textScaleFactor: 3,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: _ButtonVerticalAppBar(
                    icon: Icons.pie_chart,
                    text: "Resumen",
                    selected: url == "/home" || url == "/",
                    tooltip: "Resumen",
                    onPressed: () {
                      context.vRouter.to("/home");
                    },
                  ),
                ),
                _ButtonVerticalAppBar(
                  icon: Icons.settings,
                  text: "Opciones",
                  selected: url == "/options",
                  tooltip: "Opciones",
                  onPressed: () {
                    context.vRouter.to("/options");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ButtonVerticalAppBar extends StatelessWidget {
  const _ButtonVerticalAppBar({required this.onPressed, this.selected = false, required this.icon, required this.text, this.tooltip});

  final VoidCallback onPressed;
  final bool selected;
  final IconData icon;
  final String text;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        children: [
          if (!selected)
            Tooltip(child: Icon(icon, size: 30, color: selected ? Colors.white : Colors.white54), message: tooltip)
          else
            Icon(icon, size: 30, color: selected ? Colors.white : Colors.white54),
          if (selected)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                text.toUpperCase(),
                textScaleFactor: 1.3,
              ),
            )
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.all(const Size(90, 90)),
      ),
    );
  }
}
