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

  Future<Response?> getAllCaburant() async {
    addInterceptors();
    try {
      final response = await dio.get('/fuel-types');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getAllCategorie() async {
    addInterceptors();
    try {
      final response = await dio.get('/car-categories');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getAllTypeVehicule() async {
    addInterceptors();
    try {
      final response = await dio.get('/type-cars');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getAllTypeRemoque() async {
    addInterceptors();
    try {
      final response = await dio.get('/trailers');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getAllMarque() async {
    addInterceptors();
    try {
      final response = await dio.get('/brands');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response> addFacture(Map<String, dynamic> facturetMap) async {
    addInterceptors();
    try {
      final response = await dio.post('/abonnements/M', data: facturetMap);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response?> getAccessories() async {
    addInterceptors();
    try {
      final response = await dio.get('/accessories');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<Response?> getPowerByCaburant(int caburantId) async {
    addInterceptors();
    try {
      final response = await dio.get('/get-powers/$caburantId');
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }
}
