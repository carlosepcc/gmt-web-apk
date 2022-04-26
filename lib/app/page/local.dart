import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gmt/app/component/button.dart';
import 'package:gmt/app/component/dialog.dart';
import 'package:gmt/app/component/input.dart';
import 'package:gmt/app/store/float_button_store/float_button_store.dart';
import 'package:provider/provider.dart';

import '../store/local/local_store.dart';

class LocalPage extends HookWidget {
  LocalPage({Key? key}) : super(key: key);

  Widget _myCard({required String text, required VoidCallback onClickDelete, required VoidCallback onClickChange}) => Card(
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
                    onPressed: onClickChange,
                    splashRadius: 20,
                    tooltip: "Modificar Local",
                    icon: Icon(Icons.edit),
                    color: Colors.blue,
                  ),
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

    var showFormDialogAdd = showDialogTop(context,
        body: _LocalForm(
          action: _LocalFormAction.add,
        ));

    VoidCallback showFormDialogUpdate(Local local) => showDialogTop(context,
        body: _LocalForm(
          action: _LocalFormAction.update,
          local: local,
        ));

    useEffect(() {
      floatButton.action = showFormDialogAdd;
      floatButton.state = FloatButtonState.add;
      if (store.locales == null) {
        store.list(context);
      }
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
                        .map((local) => _myCard(
                            text: local.number.toString(),
                            onClickDelete: store.delete(context, ids: [local.id]),
                            onClickChange: showFormDialogUpdate(local)))
                        .toList()));
          },
        );
      },
    ));
  }
}

class _LocalForm extends HookWidget {
  _LocalForm({Key? key, required this.action, this.local}) : super(key: key);

  final _LocalFormAction action;
  final Local? local;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LocalStore>(context);
    final number = useState<InputData>(InputData(error: action != _LocalFormAction.update));
    final circularIndicador = useState(false);

    bool valid = number.value.error;

    VoidCallback onEnter() => () {
          if (!valid) {
            circularIndicador.value = true;
            if (action == _LocalFormAction.update && local != null) {
              store.update(context, id: local!.id, number: number.value.value)().then((value) {
                Navigator.of(context).pop();
                circularIndicador.value = false;
              });
            } else {
              store.save(context, number: number.value.value)().then((value) {
                Navigator.of(context).pop();
                circularIndicador.value = false;
              });
            }
          }
        };

    Widget? getAddButton(bool valid) {
      if (action == _LocalFormAction.update && local != null) {
        return AddButton(
          onPressed: valid ? null : store.update(context, id: local!.id, number: number.value.value),
          popNavigator: true,
        );
      } else {
        return AddButton(
          onPressed: !valid ? store.save(context, number: number.value.value) : null,
          popNavigator: true,
        );
      }
      return null;
    }

    String? getDefaultValue() {
      if (action == _LocalFormAction.update && local != null) {
        return local!.number.toString();
      }
      return null;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(action == _LocalFormAction.add ? "Nuevo Local" : "Modificar Local", textScaleFactor: 2),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: InputNumber(
            defaultValue: getDefaultValue(),
            error: number.value.error,
            onChange: (data) => number.value = data,
            onEnterPress: onEnter(),
          ),
        ),
        DialogButtons(
            addButton: !circularIndicador.value
                ? getAddButton(valid)
                : SizedBox(
                    child: AddButton(
                      circularIndicador: true,
                    ),
                  ))
      ],
    );
  }
}

enum _LocalFormAction { add, update }
