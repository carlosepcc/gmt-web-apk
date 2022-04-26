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
  Future<bool> Function() save(BuildContext context, {required String number}) => () async {
        try {
          Response response = await _axios.post(path: "/local", data: {"number": number});
          var pivote = locales!;
          pivote.add(Local.request(response.data));
          locales = pivote;
        } on DioError catch (e) {
          showSnackBar(context, error: e);
          return false;
        }
        return true;
      };

  @action
  Future<bool> Function() delete(BuildContext context, {required List<int> ids}) => () async {
        try {
          Response<List> response = await _axios.delete<List>(path: "/local", data: ids);
          var pivote = locales!;
          pivote.removeWhere((local) {
            bool salida = false;
            for (var id in response.data!) {
              if (salida) return salida;
              salida = id == local.id;
            }
            return salida;
          });
          locales = pivote;
        } on DioError catch (e) {
          showSnackBar(context, error: e);
          return false;
        }
        return false;
      };

  @action
  Future<bool> Function() update(BuildContext context, {required int id, required String number}) => () async {
        try {
          Response response = await _axios.put(path: "/local", data: {"id": id, "number": number});
          var pivote = locales!;
          var local = Local.request(response.data);
          int position = pivote.indexWhere((element) => element.id == local.id);
          pivote[position] = local;
          locales = pivote;
        } on DioError catch (e) {
          showSnackBar(context, error: e);
          return false;
        }
        return false;
      };
}

class Local {
  final int id;
  final int number;

  Local({required this.number, required this.id});

  Local.request(dynamic local) : this(number: local["number"], id: local["id"]);

  @override
  String toString() {
    return '{number: $number}';
  }

  dynamic toJson() {
    return {"number": number};
  }
}
