import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../store/local/local_store.dart';

class Local extends HookWidget {
  const Local({Key? key}) : super(key: key);

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

    return Expanded(
        child: FutureBuilder(
            future: store.list(context: context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (store.locales.isNotEmpty) {
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
                              children: store.locales.map((e) => _myCard(text: e.number.toString())).toList()));
                    },
                  );
                } else {
                  return Center(
                    child: Text("No hay Locales"),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
