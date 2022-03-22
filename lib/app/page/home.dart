import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            context.vRouter.to('/home');
          },
          child: const Text("Home")),
    );
  }
}
