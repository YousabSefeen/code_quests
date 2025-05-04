import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/login_cubit.dart';

import '../../../../core/animations/animated_gradient_background.dart';
import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../../../../core/enum/auth_state.dart';
import '../controller/states/login_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_button.dart';
import '../widgets/login_form_fields.dart';
import '../widgets/new_user_register_prompt.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;

  late TextEditingController passwordController;

  void _initializeControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void _disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    _initializeControllers();

    super.initState();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registeredUserEmail =
        ModalRoute.of(context)?.settings.arguments as String?;

    emailController.text = registeredUserEmail ?? '';
    print('_LoginScreenState.build');
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const AnimatedGradientBackground(),
            BlocListener<LoginCubit, LoginState>(
              listenWhen: (previousState, state) =>
                  previousState.loginStatus != state.loginStatus,
              listener: (context, state) => handleLoginState(
                context: context,
                loginState: state.loginStatus,
              ),
              child: FadeInUp(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              const AuthHeader(isLogin: true),
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
                                    children: <Widget>[
                                      const SizedBox(height: 5),
                                      LoginFormFields(
                                        emailController: emailController,
                                        passwordController: passwordController,
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30,),
                                        child: CustomButton(
                                          isLoading: context.watch<LoginCubit>().state.loginStatus==AuthState.loading,
                                          text: 'Login',
                                          onPressed: () =>
                                              _onLoginPressed(context),
                                        ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    final provider = context.read<LoginCubit>();
    final errorMsg = provider.validateLoginInput(
      emailController.text,
      passwordController.text,
    );
    if (errorMsg != null) {
      AppAlerts.showErrorSnackBar(context, errorMsg);
    } else {
      provider.login(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  void handleLoginState({
    required BuildContext context,
    required AuthState loginState,
  }) {
    Future.microtask(() {
      if (loginState == AuthState.success) {
        _navigateToHomeScreen(context);

      } else if (loginState == AuthState.error) {
        _showErrorSnackBar(context);

      }
    });
  }

  void _navigateToHomeScreen(BuildContext context) =>
      AppRouter.pushNamedAndRemoveUntil(context, AppRouterNames.home);



  void _showErrorSnackBar(BuildContext context) => AppAlerts.showErrorSnackBar(
        context,
        context.read<LoginCubit>().state.error ?? 'Unknown error occurred.',
      );
}
