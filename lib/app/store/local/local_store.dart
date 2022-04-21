import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gmt/app/helper/snack_bar.dart';
import 'package:mobx/mobx.dart';

import '../../helper/axios.dart';

part 'local_store.g.dart';

class LocalStore = _LocalStore with _$LocalStore;

abstract class _LocalStore with Store {
  final Axios _axios = Axios();

  @observable
  List<Local>? locales;

  @action
  Future<bool> list(BuildContext context) async {
    try {
      Response<List> response = await _axios.get<List>(path: "/local");
      locales = response.data!.map((e) => Local.request(e)).toList();
    } on DioError catch (e) {
      showSnackBar(context, error: e);
      return false;
    }
    return true;
  }

  @action
  Future<bool> Function() save(BuildContext context, {required String username}) => () async {
        try {
          Response response = await _axios.post(path: "/local", data: {"number": username});
          var pivote = locales!;
          pivote.add(Local.request(response.data));
          locales = pivote;
        } on DioError catch (e) {
          showSnackBar(context, error: e);
          return false;
        }
        return true;
      };
}

class Local {
  final int number;

  Local({required this.number});

  Local.request(dynamic local) : this(number: local["number"]);

  @override
  String toString() {
    return '{number: $number}';
  }

  dynamic toJson() {
    return {"number": number};
  }
}
