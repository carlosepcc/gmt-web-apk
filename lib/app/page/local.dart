import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gmt/app/component/button.dart';
import 'package:gmt/app/component/dialog.dart';
import 'package:gmt/app/component/input.dart';
import 'package:gmt/app/store/float_button_store/float_button_store.dart';
import 'package:provider/provider.dart';

import '../store/local/local_store.dart';

class Local extends HookWidget {
  Local({Key? key}) : super(key: key);

  Widget _myCard({required String text, required VoidCallback onClickDelete}) => Card(
        elevation: 3,
        child: SizedBox(
          width: 150,
          height: 170,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  IconButton(
                      onPressed: onClickDelete,
                      splashRadius: 20,
                      tooltip: "Eliminar Local",
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(text),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LocalStore>(context);
    final floatButton = Provider.of<FloatButtonStore>(context);

    var showFormDialog = showDialogTop(context, body: _LocalForm());

    useEffect(() {
      floatButton.action = showFormDialog;
      floatButton.state = FloatButtonState.add;
      store.list(context);
      return null;
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
                    children: store.locales!
                        .map((local) => _myCard(text: local.number.toString(), onClickDelete: store.delete(context, ids: [local.id])))
                        .toList()));
          },
        );
      },
    ));
  }
}

class _LocalForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LocalStore>(context);
    final username = useState<InputData>(InputData(error: true));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text("Nuevo Local", textScaleFactor: 2),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: InputNumber(
            onChange: (data) => username.value = data,
          ),
        ),
        DialogButtons(
            addButton: AddButton(
          onPressed: !username.value.error ? store.save(context, username: username.value.value) : null,
          popNavigator: true,
        ))
      ],
    );
  }
}
