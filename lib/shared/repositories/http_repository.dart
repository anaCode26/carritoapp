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

  /// Maneja los errores de la petición HTTP y los rechaza con el error original
  /// para que sea manejado por el cubit correspondiente y no por el interceptor.
  void _onErrorHandler(DioError dioError, ErrorInterceptorHandler handler) {
    handler.reject(DioError(requestOptions: dioError.requestOptions, error: dioError.error));
  }

  /// Realiza una petición GET al servidor con los parámetros proporcionados
  Future<Response> get(String path, {Options? options, Map<String, dynamic> queryParameters = const {}}) async {
    return await _dio.get(
      path,
      options: options ?? Options(),
      queryParameters: queryParameters,
    );
  }

  /// Realiza una petición POST al servidor con los parámetros proporcionados
  Future<Response> post(String path, {data, Options? options, Map<String, dynamic> queryParameters = const {}}) async {
    return await _dio.post(
      path,
      data: data,
      options: options ?? Options(),
      queryParameters: queryParameters,
    );
  }
}
