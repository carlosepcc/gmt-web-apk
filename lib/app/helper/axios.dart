import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Axios {
  final Dio dio = Dio(BaseOptions(baseUrl: "http://localhost:8080"));

  post({required String path, required dynamic data, bool authorization = true}) async {
    if (authorization) {
      final prefs = await SharedPreferences.getInstance();
      String? jwt = prefs.getString("jwt");
      if (jwt != null) {
        return await dio.post(path, data: data, options: Options(headers: {"Authorization": jwt}));
      }
    }
    return await dio.post(path, data: data);
  }
}
