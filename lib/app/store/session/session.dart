import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:gmt/app/helper/snack_bar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/axios.dart';

part 'session.g.dart';

class Session = _Session with _$Session;

abstract class _Session with Store {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Axios _axios = Axios();

  @observable
  String? jwt;

  @observable
  String username = "user";

  @computed
  bool get isInSession => jwt is String;

  @action
  init({String? token}) async {
    final SharedPreferences prefs = await _prefs;
    //Comprobación del token
    if (token != null) {
      prefs.setString("jwt", token);
      jwt = token;
    } else {
      token = prefs.getString("jwt");
      if (token != null && !JwtDecoder.isExpired(token)) jwt = token;
    }
    if (jwt != null) username = JwtDecoder.decode(jwt as String)["sub"];
  }

  login({required String username, required String password, required BuildContext context}) async {
    try {
      Response response = await _axios.post(path: "/login", data: {"username": username, "password": password}, authorization: false);
      init(token: response.data as String);
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        MySnackBar(context: context, message: e.response?.data["message"] ?? "Error de Conexión", type: TypeSnackBar.error).showSnackBar();
      }
    }
  }

  logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    jwt = null;
  }
}
