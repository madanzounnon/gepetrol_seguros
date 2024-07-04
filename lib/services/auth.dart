import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gepetrol_eguros/services/dioInterceptor.dart';

class Auth {
  String _baseUrl = "https://seguros.fifonsi.net/api";

  Dio dio = Dio(BaseOptions(
    baseUrl: "https://seguros.fifonsi.net/api",
  ));
  addInterceptors() {
    dio.options.validateStatus = (status) {
      return status! < 500; // Accepte les codes d'état inférieurs à 500
    };
    dio.interceptors.add(DioInterceptor());
  }

  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  Future<http.Response?> sendVerifyCodes(String email) async {
    try {
      var url = Uri.parse('https://seguros.fifonsi.net/api/check-email');

      // Les données que vous souhaitez envoyer
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Connection": "keep-alive",
        "Accept": "*/*"
      };
      String json = jsonEncode({"email": "$email"});

      // Faire la requête POST
      final response = await http.post(url, headers: headers, body: json);
      print(response);
      print('response');
      if (response.statusCode == 201) {
        // Si la requête est réussie, retourner la réponse
        print(response);
        print('response');
        print(json);
        return response;
      } else if (response.statusCode == 307) {
        // Si le statut est 307, suivre la redirection
        print(response.headers['location']);
        var newUrl = response.headers['location'];
        print("newUrl");
        if (newUrl != null) {
          var redirectedResponse =
              await http.post(Uri.parse(newUrl), headers: headers, body: json);
          print("redirectedResponse.body.toString()");
          print(redirectedResponse.statusCode);
          return redirectedResponse;
        } else {
          print('Redirection location is null');
          return null;
        }
      } else {
        // Si la requête échoue, afficher le code de statut
        print(
            'Failed to make POST request. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print("dddddddddddddddddddddddddddddddddd");
      print(e);
      return null;
    }
  }

  Future<Response> sendVerifyCode(String email) async {
    addInterceptors();
    print(email);
    try {
      final response = await dio.post('/check-email', data: {
        'email': email,
      });
      print("response responseresponseresponse");
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> sendVerifyCodeReset(String email) async {
    addInterceptors();
    print(email);
    try {
      final response = await dio.post('/forget-password', data: {
        'email': email,
      });
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> authenticate(String email, String password) async {
    addInterceptors();
    try {
      final response = await dio.post('/login', data: {
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
      final response = await dio.post('/reset-password', data: {
        'email': email,
        'new_password': password,
      });
      print(response);
      return response;
    } on DioError catch (e) {
      return e.response!;
    }
  }

  Future<Response> register(Map<String, dynamic>? userData) async {
    try {
      final response = await dio.post('/validate-account', data: userData);
      print(response);
      return response;
    } on DioError catch (e) {
      print("e.response!.data");
      print(e.response);
      return e.response!;
    }
  }
}
