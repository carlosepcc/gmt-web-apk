// ignore: avoid_web_libraries_in_flutter
import "dart:html";

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Axios {
  final String _url = window.location.hostname! == "localhost" ? "http://localhost:8080" : "https://jesusfvb-gmt.herokuapp.com";

  get _dio => Dio(BaseOptions(baseUrl: _url));

  post<T>({required String path, required dynamic data, bool authorization = true}) async {
    Options? options = await _getOptionToken(authorization);
    return await _dio.post(path, data: data, options: options);
  }

  get<T>({required String path, bool authorization = true}) async {
    Options? options = await _getOptionToken(authorization);
    return await _dio.get<T>(path, options: options);
  }

  Future<Options?> _getOptionToken(bool authorization) async {
    if (authorization) {
      final prefs = await SharedPreferences.getInstance();
      String? jwt = prefs.getString("jwt");
      if (jwt != null) {
        if (JwtDecoder.isExpired(jwt)) {
          throw Exception("Token expired");
        }
        return Options(headers: {"Authorization": jwt});
      }
    }
    return null;
  }
}
