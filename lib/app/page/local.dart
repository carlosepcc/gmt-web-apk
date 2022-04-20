import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gmt/app/component/dialog.dart';
import 'package:gmt/app/component/input.dart';
import 'package:gmt/app/store/float_button_store/float_button_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../store/local/local_store.dart';

class Local extends HookWidget {
  Local({Key? key}) : super(key: key);

  Widget _myCard({required String text}) => Card(
        elevation: 3,
        child: SizedBox(
          width: 150,
          height: 200,
          child: Center(
            child: Text(text),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LocalStore>(context);
    final floatButton = Provider.of<FloatButtonStore>(context);
    final numberC = useState<InputData>(InputData(value: "", error: false));

    var showFormDialog = showFormAddDialog(context, addFunction: store.list, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InputNumber(controller: numberC),
      )
    ]);

    useEffect(() {
      floatButton.action = showFormDialog;
      store.list(context: context);
      return () {};
    }, []);

    return Expanded(child: Observer(
      builder: (BuildContext context) {
        if (store.locales == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (store.locales!.isEmpty) {
          return Center(
            child: Text("No hay locales para mostrar"),
          );
        }
        return DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 1,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 5,
                    runSpacing: 5,
                    children: store.locales!.map((e) => _myCard(text: e.number.toString())).toList()));
          },
        );
      },
    ));
  }
}
