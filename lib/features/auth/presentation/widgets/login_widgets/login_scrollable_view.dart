import 'package:flutter/material.dart';

import '../../../../../core/constants/themes/app_colors.dart';
import '../auth_header.dart';
import 'login_button.dart';
import 'login_form_fields.dart';
import 'new_user_register_prompt.dart';

class LoginScrollableView extends StatelessWidget {
  final BoxConstraints constraints;
  final bool isKeyboardVisible;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginScrollableView({
    super.key,
    required this.constraints,
    required this.isKeyboardVisible,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom:
            isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 0,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: constraints.maxHeight,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.4,
                child: const Center(child: AuthHeader(isLogin: true)),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoginFormFields(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      LoginButton(
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      const NewUserRegisterPrompt(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
