import 'package:flutter/material.dart';
import 'package:gmt/app/store/session/session.dart';

class MyAppBar extends AppBar {
  MyAppBar(Session session, {Key? key})
      : super(key: key, title: const Text("GMT"), toolbarHeight: 40, actions: [
          PopupMenuButton(
              tooltip: "Opciones",
              child: CircleAvatar(child: Text(session.username[0].toUpperCase())),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text("Salir"),
                      onTap: session.logout,
                    )
                  ])
        ]);
}
