import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

VoidCallback showDialogTop(BuildContext context, {required Widget body}) => () => showAnimatedDialog(
    context: context, barrierDismissible: true, animationType: DialogTransitionType.slideFromTop, builder: (_) => _DialogTop(body: body));

class _DialogTop extends StatelessWidget {
  _DialogTop({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          width: 300,
          padding: EdgeInsets.only(bottom: 8),
          child: Material(
            child: Column(
              children: [body],
            ),
          ),
        ),
      ],
    );
  }
}

class DialogButtons extends StatelessWidget {
  const DialogButtons({Key? key, required this.addButton}) : super(key: key);

  final Widget? addButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Padding(padding: const EdgeInsets.all(10.0), child: addButton)),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar")),
        ))
      ],
    );
  }
}
