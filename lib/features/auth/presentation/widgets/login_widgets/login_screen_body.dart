import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';

import '../../controller/states/login_state.dart';
import 'login_scrollable_view.dart';


class LoginScreenBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginScreenBody({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, LazyRequestState>(
      selector: (state) => state.loginStatus,
      builder: (context, loginStatus) {
        return FadeInUp(
          child: KeyboardVisibilityBuilder(
            builder: (context, isKeyboardVisible) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return LoginScrollableView(
                    constraints: constraints,
                    isKeyboardVisible: isKeyboardVisible,
                    emailController: emailController,
                    passwordController: passwordController,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
