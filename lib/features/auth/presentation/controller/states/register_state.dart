




import '../../../../../core/enum/auth_state.dart';
import '../../../../../core/enum/user_type.dart';

class RegisterState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final UserType userType;
  final AuthState registerState;
  final String? error;
  final bool isSendEmailVerification;
  final bool isAuthGoogle;

  const RegisterState({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.userType,
    required this.registerState,
    required this.error,
    required this.isSendEmailVerification,
    required this.isAuthGoogle,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isPasswordVisible: true,
      isConfirmPasswordVisible: true,
      userType: UserType.client,
      registerState: AuthState.init,
      error: null,
      isSendEmailVerification: false,
      isAuthGoogle: false,
    );
  }

  RegisterState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    UserType? userType,
    AuthState? registerState,
    String? error,
    bool? isSendEmailVerification,
    bool? isAuthGoogle,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      userType: userType ?? this.userType,
      registerState: registerState ?? this.registerState,
      error: error,
      isSendEmailVerification: isSendEmailVerification ?? this.isSendEmailVerification,
      isAuthGoogle: isAuthGoogle ?? this.isAuthGoogle,
    );
  }
}
