import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

VoidCallback showFormAddDialog(BuildContext context,
        {required List<Widget> children, Future<bool> Function({required BuildContext context})? addFunction}) =>
    () => showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromTop,
        builder: (_) => _FormAdd(
              children: children,
              addFunction: addFunction,
            ));

class _FormAdd extends HookWidget {
  _FormAdd({Key? key, required this.children, this.addFunction}) : super(key: key);

  final List<Widget> children;

  final Future<bool> Function({required BuildContext context})? addFunction;

  @override
  Widget build(BuildContext context) {
    VoidCallback? getFunction() {
      if (addFunction != null) {
        return () {
          addFunction!(context: context);
        };
      }
      return null;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
          width: 300,
          child: Column(
            children: [
              Material(
                child: Column(
                  children: children,
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(onPressed: getFunction(), child: Text("Aceptar")),
                  )),
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
