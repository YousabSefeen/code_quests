import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/enum/password_visibility_state.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';
import 'package:flutter_task/features/auth/presentation/controller/states/login_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/themes/app_colors.dart';
import 'custom_form_field.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormFields(
      {super.key,
      required this.emailController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.coolBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          children: [
            _buildEmailField(),
            _buildPasswordField(context),
          ],
        ),
      ),
    );
  }

  CustomFormField _buildEmailField() {
    return CustomFormField(
      title: 'Email',
      icon: FontAwesomeIcons.envelope,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  _buildPasswordField(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) => state.isPasswordVisible,
      builder: (context, isLoginPasswordVisible) {
        return CustomFormField(
          title: 'Password',
          icon: FontAwesomeIcons.lock,
          controller: passwordController,
          keyboardType: TextInputType.text,
          obscureText: isLoginPasswordVisible,
          suffixIcon: IconButton(
            onPressed: () =>
                context.read<LoginCubit>().togglePasswordVisibility(),
            icon: Icon(
              isLoginPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
