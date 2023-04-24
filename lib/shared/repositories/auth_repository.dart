import 'package:carritoapp/shared/const/endpoints_const.dart';
import 'package:carritoapp/shared/repositories/http_repository.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final HTTPRepository httpRepository;

  AuthRepository({
    required this.httpRepository,
  });

  /// Inicia sesión con las credenciales proporcionadas
  Future<Response> login(String username, String password) async {
    return await httpRepository.post(
      '$baseUrl$loginEndpoint',
      data: {
        'username': username,
        'password': password,
      },
    );
  }
}
