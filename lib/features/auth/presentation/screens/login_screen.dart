import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';

import '../../../../core/animations/animated_gradient_background.dart';
import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../controller/states/login_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/login_button.dart';
import '../widgets/login_form_fields.dart';
import '../widgets/new_user_register_prompt.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registeredUserEmail =
        ModalRoute.of(context)?.settings.arguments as String?;
    emailController.text = registeredUserEmail ?? '';



    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const AnimatedGradientBackground(),
            BlocSelector<LoginCubit, LoginState, LazyRequestState>(
              selector: (state) => state.loginStatus,
              builder: (context, loginStatus) {

                return FadeInUp(
                  child: KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            padding: EdgeInsets.only(
                              bottom: isKeyboardVisible
                                  ? MediaQuery.of(context).viewInsets.bottom
                                  : 0,
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
                                      child: const Center(
                                          child: AuthHeader(isLogin: true)),
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
                                              passwordController:
                                                  passwordController,
                                            ),
                                            LoginButton(
                                              emailController: emailController,
                                              passwordController:
                                                  passwordController,
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
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


}
