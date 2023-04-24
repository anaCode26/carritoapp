import 'package:dio/dio.dart';

class HTTPRepository {
  final Dio _dio;
  final Duration connectionTimeout = const Duration(milliseconds: 30000);
  final Duration receiveTimeout = const Duration(milliseconds: 30000);

  HTTPRepository() : _dio = Dio() {
    _dio
      ..interceptors.add(InterceptorsWrapper(onError: _onErrorHandler))
      ..options.connectTimeout = connectionTimeout
      ..options.receiveTimeout = receiveTimeout
      ..options.headers = {
        "Accept": "*/*",
      };
  }

  void _onErrorHandler(DioError dioError, ErrorInterceptorHandler handler) {
    handler.reject(DioError(requestOptions: dioError.requestOptions, error: dioError.error));
  }

  Future<Response> get(String path, {Options? options, Map<String, dynamic> queryParameters = const {}}) async {
    return await _dio.get(
      path,
      options: options ?? Options(),
      queryParameters: queryParameters,
    );
  }

  Future<Response> post(String path, {data, Options? options, Map<String, dynamic> queryParameters = const {}}) async {
    return await _dio.post(
      path,
      data: data,
      options: options ?? Options(),
      queryParameters: queryParameters,
    );
  }
}
