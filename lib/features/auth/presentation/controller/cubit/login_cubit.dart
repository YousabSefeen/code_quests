import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enum/auth_state.dart';
import '../../../data/repository/auth_repository.dart';
import '../states/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(const LoginState());

  void togglePasswordVisibility() => emit(
        state.copyWith(isLoginPasswordVisible: !state.isPasswordVisible),
      );

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(loginStatus: AuthState.loading, error: null));

    final response =
        await authRepository.login(email: email, password: password);

    response.fold((failure) {
      emit(
        state.copyWith(
          loginStatus: AuthState.error,
          error: failure.toString(),
        ),
      );
    }, (success) async {
      emit(state.copyWith(loginStatus: AuthState.success));
    });
  }

  String? validateLoginInput(String email, String password) {
    if (email.isEmpty) return 'Please enter your email';
    if (!email.contains('@')) return 'Enter a valid email';
    if (password.isEmpty) return 'Please enter your password';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void resetState() => emit(const LoginState());

  Future<void> logout() async => await authRepository.logout();
}
