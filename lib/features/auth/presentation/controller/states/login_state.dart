import 'package:flutter_task/core/enum/lazy_request_state.dart';

class LoginState {
  final bool isPasswordVisible;
  final LazyRequestState loginStatus;
  final String? loginError;

  const LoginState({
    this.isPasswordVisible = true,
    this.loginStatus = LazyRequestState.lazy,
    this.loginError = '',
  });

  LoginState copyWith({
    bool? isPasswordVisible,
    LazyRequestState? loginStatus,
    String? loginError,
  }) =>
      LoginState(
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        loginStatus: loginStatus ?? this.loginStatus,
        loginError: loginError ?? this.loginError,
      );
}
