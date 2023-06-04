import 'package:dio/dio.dart';

class Diohelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        // headers: {'Content-Type': 'application/json'},
        receiveDataWhenStatusError: true));
  }

  static Future<Response>? getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) {
    dio?.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio?.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response>? postData({
    required String url,
    required Map<String, dynamic> data,
    String? lang = 'ar',
    String? token,
  }) {
    dio?.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio?.post(
      url,
      data: data,
    );
  }
}
