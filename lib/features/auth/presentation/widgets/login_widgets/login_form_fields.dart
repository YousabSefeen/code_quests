import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';
import 'package:flutter_task/features/auth/presentation/controller/states/login_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/themes/app_colors.dart';
import '../../controller/form_controllers/login_controllers.dart';
import '../custom_form_field.dart';

class LoginFormFields extends StatelessWidget {
  final LoginControllers loginControllers;

  const LoginFormFields({super.key, required this.loginControllers,});

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
      title: AppStrings.email,
      icon: FontAwesomeIcons.envelope,
      controller: loginControllers.emailController,
      keyboardType: TextInputType.emailAddress,
    );
  }

  _buildPasswordField(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) => state.isPasswordVisible,
      builder: (context, isLoginPasswordVisible) {
        return CustomFormField(
          title: AppStrings.password,
          icon: FontAwesomeIcons.lock,
          controller: loginControllers.passwordController,
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
