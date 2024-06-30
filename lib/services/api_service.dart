import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gepetrol_eguros/services/dioInterceptor.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(baseUrl: "https://seguros.fifonsi.net/api"));
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

  Future<Response?> getUser() async {
    addInterceptors();
    try {
      final response = await dio.get('/me');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  getAllCaburant() {}

  getAllCategorie() {}

  getAllTypeVehicule() {}

  getAllTypeRemoque() {}

  getAllMarque() {}
}
