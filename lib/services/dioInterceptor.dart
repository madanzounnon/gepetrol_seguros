import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioInterceptor extends Interceptor {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    final token = sharedPreferences.getString("token");
    options.headers.addAll({
      "Content-Type": "application/json",
      "Connection": "keep-alive",
      "Accept": "*/*"
    });
    // get token from the storage
    if (token != null) {
      options.headers.addAll({
        "Authorization": "Bearer $token",
      });
    }
    print(options.headers);
    return super.onRequest(options, handler);
  }

  /*void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the user is unauthorized.
    if (err.response?.statusCode == 401) {
      // Refresh the user's authentication token.
      await refreshToken();
      // Retry the request.
      try {
        handler.resolve(await _retry(err.requestOptions));
      } on DioException catch (e) {
        // If the request fails again, pass the error to the next interceptor in the chain.
        handler.next(e);
      }
      // Return to prevent the next interceptor in the chain from being executed.
      return;
    }
    // Pass the error to the next interceptor in the chain.
    handler.next(err);
  }*/

  /*Future<Response<dynamic>> refreshToken() async {
   var response = await dio.post(APIs.refreshToken,
        options: Options(
          headers: {"Refresh-Token": "refresh-token" }));
    // on success response, deserialize the response
    if (response.statusCode == 200) {
      // LoginRequestResponse requestResponse =
      //    LoginRequestResponse.fromJson(response.data);
      // UPDATE the STORAGE with new access and refresh-tokens
      return response;
    }
  }*/

  /* Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // Create a new `RequestOptions` object with the same method, path, data, and query parameters as the original request.
    final options = Options(
      method: requestOptions.method,
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
  
    // Retry the request with the new `RequestOptions` object.
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }  */
}

class DioInstence {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://seguros.fifonsi.net/api",
    followRedirects: true,
    validateStatus: (status) {
      return status! < 500; // Accepte les codes d'état inférieurs à 500
    },
  ));
}
