import 'package:carritoapp/shared/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit({
    required this.authRepository,
  }) : super(AuthInitial());

  Future<void> login({required String username, required String password}) async {
    try {
      emit(AuthLoading());
      await authRepository.login(username, password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError('Credenciales inválidas.'));
    }
  }
}
