import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gepetrol_eguros/services/dioInterceptor.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(baseUrl: "https://webapp.africabourse-am.net/api"));
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  addInterceptors() {
    dio.interceptors.add(DioInterceptor());
  }

  Future<Response> getNotificationEstLu(int id) async {
    addInterceptors();
    try {
      final response = await dio.put('/notifications/lu/$id');
      print("response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> rachat(int id, Map<String, dynamic> souscrireMap) async {
    addInterceptors();
    try {
      final response = await dio.post('/offers/$id/sell', data: souscrireMap);
      print("response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> simuler(int offre, Map<String, dynamic> simulerMap) async {
    addInterceptors();
    try {
      final response =
          await dio.post('/offers/$offre/simulation', data: simulerMap);
      print("response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response?> souscrire(int id, Map<String, dynamic> souscrireMap) async {
    addInterceptors();
    print(souscrireMap);
    try {
      final response =
          await dio.post('/offers/$id/subscribe', data: souscrireMap);
      print("response");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getHistoriques() async {
    addInterceptors();
    try {
      final response = await dio.get('/history');
      // print("lib/models/data.json");
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getAlloffres() async {
    addInterceptors();
    try {
      final response = await dio.get('/offers');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getAllPortefeuilles() async {
    addInterceptors();
    try {
      final response = await dio.get('/portefeuilles');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getUser() async {
    addInterceptors();
    try {
      final response = await dio.get('/auth/user');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getCheckOffre(int id) async {
    addInterceptors();
    try {
      final response = await dio.get('/offers/$id/check');
      print(response);
      return response;
    } on DioError catch (e) {
      print(e.response);
      return e.response;
    }
  }

  Future<Response?> getprintPortefeuille() async {
    addInterceptors();
    try {
      final response = await dio.get('/print-portefeuille');
      print(response);
      return response;
    } on DioError catch (e) {
      print(e.response);
      return e.response;
    }
  }

  Future<Response?> getPrintReleve() async {
    addInterceptors();
    try {
      final response = await dio.get('/print-releve');
      print(response);
      return response;
    } on DioError catch (e) {
      print(e.response);
      return e.response;
    }
  }

  Future<Response?> firstSouscription(FormData dataMap) async {
    //addInterceptors();
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    final token = sharedPreferences.getString("token");
    if (token != null) {
      dio.options.headers.addAll({
        "Authorization": "Bearer $token",
      });
    }
    dio.options.headers.addAll({
      'Content-Type': 'multipart/form-data',
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
    });

    // dio.options.headers.addAll({'Content-Type': 'multipart/form-data'});
    print(dio.options.headers);
    print(dio.options.baseUrl);
    print(dataMap.fields);
    print(dataMap.files.first.value);
    print(dataMap.files.last);
    try {
      print("trytrytrytrytrytrytrytrytrytry");
      final response = await dio.post('/add-user-infos', data: dataMap);
      print(response);
      return response;
    } on DioError catch (e) {
      print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      print(e);
      print(e.response?.data);
      return e.response;
    }
  }

  Future<Response?> demandeUpdate(FormData dataMap) async {
    //addInterceptors();
    print("dataMap");
    print(dataMap);
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    final token = sharedPreferences.getString("token");
    if (token != null) {
      dio.options.headers.addAll({
        "Authorization": "Bearer $token",
      });
    }
    dio.options.headers.addAll({
      'Content-Type': 'multipart/form-data',
      "Connection": "keep-alive",
      "Accept-Encoding": "gzip, deflate, br",
    });

    try {
      final response = await dio.post('/update-request', data: dataMap);
      print(response);
      return response;
    } on DioError catch (e) {
      print(e);
      print(e.response?.data);
      return e.response;
    }
  }
}
