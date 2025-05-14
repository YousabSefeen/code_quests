import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enum/lazy_request_state.dart';
import '../../../../../core/enum/user_type.dart';
import '../../../data/repository/auth_repository.dart';
import '../states/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;

  RegisterCubit({required this.authRepository})
      : super(RegisterState.initial());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  UserType _userType = UserType.client;

  void toggleUserType(UserType type) {
    _userType = _userType != type ? type : _userType;
    emit(state.copyWith(userType: _userType));
  }

  String? validateRegistrationInputs({
    required String userName,
    required String phoneNumber,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (userName.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      return 'Please fill all fields';
    }

    if (userName.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(phoneNumber)) {
      return 'Enter a valid phone number';
    }

    if (!email.contains('@') || !email.contains('.')) {
      return 'Enter a valid email';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (confirmPassword != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(registerState: LazyRequestState.loading));

    final response = await authRepository.register(
      name: name,
      phone: phone,
      email: email,
      password: password,
      role: _userType.name,
    );

    response.fold((failure) {
      emit(state.copyWith(
        registerState: LazyRequestState.error,
        error: failure.toString(),
      ));
    }, (success) {
      emit(state.copyWith(
        registerState: LazyRequestState.loaded,
      ));
    });
  }

  void resetState() => emit(RegisterState.initial());
}
