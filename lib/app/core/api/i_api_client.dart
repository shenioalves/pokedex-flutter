import 'package:dio/dio.dart';

abstract class ApiClient {
  Future<Response<dynamic>> post({
    required Object? data,
    required String endpoint,
    bool isForm = false,
  });

  Future<Response<dynamic>> put({
    required Object? data,
    required String endpoint,
    bool isForm = false,
  });

  Future<Response<dynamic>> get({
    Map<String, dynamic>? queryParameters,
    required String endpoint,
  });

  Future<Response<dynamic>> delete({
    Map<String, dynamic>? queryParameters,
    required String endpoint,
  });

  Future<Response<dynamic>> patch({required String endpoint});
}