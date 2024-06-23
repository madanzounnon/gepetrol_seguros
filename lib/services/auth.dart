import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gepetrol_eguros/services/dioInterceptor.dart';

class Auth {
  String _baseUrl = "https://webapp.africabourse-am.net/api";

  Dio dio = Dio(BaseOptions(baseUrl: "https://webapp.africabourse-am.net/api"));
  addInterceptors() {
    dio.interceptors.add(DioInterceptor());
  }

  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  Future<Response> sendVerifyCode(String country, String email) async {
    addInterceptors();
    print(email);
    print(country);
    try {
      final response = await dio.post('/auth/send-verification', data: {
        'email': email,
        'country': country,
      });
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> sendVerifyCodeReset(String email) async {
    addInterceptors();
    print(email);
    try {
      final response = await dio.post('/auth/reset-password-code', data: {
        'email': email,
      });
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> authenticate(String email, String password) async {
    print(email);
    print(password);
    addInterceptors();
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> resetPassword(String email, String password) async {
    addInterceptors();
    try {
      final response = await dio.post('/auth/reset-password', data: {
        'email': email,
        'password': password,
      });
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> register(Map<String, dynamic>? userData) async {
    try {
      final response =
          await dio.post('/auth/verify-code-register', data: userData);
      print(response);
      return response;
    } on DioError catch (e) {
      print("e.response!.data");
      print(e.response);
      return e.response!;
    }
  }

  // Future<Response> getUserDetails(String userId) async {
  //   try {

  //   }catch {

  //   }
  // }
}
