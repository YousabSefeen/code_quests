import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/animations/animated_gradient_background.dart';
import 'package:flutter_task/core/constants/app_alerts/app_alerts.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/app_routes/app_router_names.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/register_cubit.dart';
import 'package:flutter_task/features/auth/presentation/widgets/register_widgets/register_error_snack_bar_content.dart';

import '../controller/states/register_state.dart';
import '../widgets/register_widgets/register_body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final String emailAlreadyInUseError =
      'This email address is already in use. If it’s your account, try logging in.';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initializeControllers() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void _disposeControllers() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const AnimatedGradientBackground(),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: FadeInUp(
                  child: BlocListener<RegisterCubit, RegisterState>(
                    listenWhen: (prev, curr) =>
                        prev.registerState != curr.registerState,
                    listener: (context, state) => _handleRegisterState(
                      context,
                      state.registerState,
                    ),
                    child: RegisterBody(
                      nameController: nameController,
                      phoneController: phoneController,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      onRegisterPressed: () => _onRegisterPressed(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRegisterState(BuildContext context, LazyRequestState state) {
    if (state == LazyRequestState.loaded) {
      _navigateToVerification(context);
      _resetRegisterCubit(context);
    } else if (state == LazyRequestState.error) {
      final errorMessage = context.read<RegisterCubit>().state.error ??
          'Unknown error occurred.';
      _showError(context, errorMessage);
      _resetRegisterCubit(context);
    }
  }

  void _resetRegisterCubit(BuildContext context) {
    Future.microtask(() => context.read<RegisterCubit>().resetState());
  }

  void _navigateToVerification(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AppRouter.pushNamed(context, AppRouterNames.doctorListView);
    });
  }

  void _showError(BuildContext context, String errorMessage) {
    Future.microtask(() {
      if (errorMessage == emailAlreadyInUseError) {
        AppAlerts.showRegisterErrorSnackBar(
          context: context,
          errorMessage: errorMessage,
          content: RegisterErrorSnackBarContent(
            errorMessage: errorMessage,
            userEmail: emailController.text,
          ),
        );
      } else {
        AppAlerts.showErrorSnackBar(context, errorMessage);
      }
    });
  }

  void _onRegisterPressed(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    final cubit = context.read<RegisterCubit>();

    final validationMessage = cubit.validateRegistrationInputs(
      userName: nameController.text,
      phoneNumber: phoneController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    if (validationMessage != null) {
      AppAlerts.showErrorSnackBar(context, validationMessage);
    } else {
      cubit.register(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
