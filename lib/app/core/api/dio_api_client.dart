import 'package:dio/dio.dart';
import 'package:pokedex/app/core/api/i_api_client.dart';
import 'package:pokedex/app/core/utils/global_variables.dart';

class DioApiClientImp implements ApiClient {
  final Dio _dio;

  DioApiClientImp()
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  @override
  Future<Response> get({
    Map<String, dynamic>? queryParameters,
    required String endpoint,
  }) async {
    return await _dio.get(endpoint, queryParameters: queryParameters);
  }

  @override
  Future<Response> post({
    required Object? data,
    required String endpoint,
    bool isForm = false,
  }) async {
    return await _dio.post(
      endpoint,
      data: isForm ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );
  }

  @override
  Future<Response> put({
    required Object? data,
    required String endpoint,
    bool isForm = false,
  }) async {
    return await _dio.put(
      endpoint,
      data: isForm ? FormData.fromMap(data as Map<String, dynamic>) : data,
    );
  }

  @override
  Future<Response> patch({required String endpoint}) async {
    return await _dio.patch(endpoint);
  }

  @override
  Future<Response> delete({
    Map<String, dynamic>? queryParameters,
    required String endpoint,
  }) async {
    return await _dio.delete(endpoint, queryParameters: queryParameters);
  }
}
