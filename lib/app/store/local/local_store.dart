import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../helper/axios.dart';
import '../../helper/snack_bar.dart';

part 'local_store.g.dart';

class LocalStore = _LocalStore with _$LocalStore;

abstract class _LocalStore with Store {
  final Axios _axios = Axios();

  @observable
  List<Local>? locales;

  @action
  Future<bool> list({required BuildContext context}) async {
    try {
      Response<List> response = await _axios.get<List>(path: "/local");
      locales = response.data!.map((e) => Local(e)).toList();
    } on DioError catch (e) {
      MySnackBar(context: context, message: e.response?.data["message"] ?? "Error de Conexión", type: TypeSnackBar.error).showSnackBar();
      return false;
    }
    return true;
  }
}

class Local {
  int number = 0;

  Local(dynamic local) {
    number = local["number"];
  }

  @override
  String toString() {
    return '{number: $number}';
  }
}
