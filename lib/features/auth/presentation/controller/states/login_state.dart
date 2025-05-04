import '../../../../../core/enum/auth_state.dart';

class LoginState {
  final bool isPasswordVisible;
  final AuthState loginStatus;
  final String? error;

  const LoginState({
    this.isPasswordVisible = true,
    this.loginStatus = AuthState.init,
    this.error,
  });

  LoginState copyWith({
    bool? isLoginPasswordVisible,
    AuthState? loginStatus,
    String? error,
  }) => LoginState(
      isPasswordVisible:
      isLoginPasswordVisible ?? this.isPasswordVisible,
      loginStatus: loginStatus ?? this.loginStatus,
      error: error,
    );
}
