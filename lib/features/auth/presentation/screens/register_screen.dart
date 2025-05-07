import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/enum/auth_state.dart';
import 'package:flutter_task/features/auth/presentation/controller/cubit/register_cubit.dart';
import 'package:flutter_task/features/auth/presentation/widgets/register_role_selector.dart';

import '../../../../core/animations/animated_gradient_background.dart';
import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../controller/states/register_state.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_button.dart';
import '../widgets/register_error_snack_bar_content.dart';
import '../widgets/register_form_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailAlreadyInUseError =
      'This email address is already in use. If it’s your account, try logging in.';

  late TextEditingController nameController;

  late TextEditingController phoneController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController confirmPasswordController;

  void _initializeControllerFields() {
    nameController = TextEditingController();

    phoneController = TextEditingController();

    emailController = TextEditingController();

    passwordController = TextEditingController();

    confirmPasswordController = TextEditingController();
  }

  void _disposeControllerFields() {
    nameController.dispose();

    phoneController.dispose();

    emailController.dispose();

    passwordController.dispose();

    confirmPasswordController.dispose();
  }

  @override
  void initState() {
    _initializeControllerFields();
    super.initState();
  }

  @override
  void dispose() {
    _disposeControllerFields();
    super.dispose();
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
          child: SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const AnimatedGradientBackground(),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: FadeInUp(
                    child: BlocListener<RegisterCubit, RegisterState>(
                      listenWhen: (previousState, state) =>
                          previousState.registerState != state.registerState,
                      listener: (context, state) => handleRegisterState(
                        context: context,
                        registerState: state.registerState,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(top:5,left: 10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey, width: 1.5)),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 15.sp,
                              color: Colors.white,
                            ),
                          ),

                          const AuthHeader(isLogin: false),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.darkBlue,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.r),
                                topRight: Radius.circular(25.r),
                              ),
                            ),
                            child: Column(

                              children: <Widget>[
                                RegisterFormFields(
                                  userNameController: nameController,
                                  phoneController: phoneController,
                                  emailController: emailController,
                                  passwordController: passwordController,
                                  confirmPasswordController:
                                      confirmPasswordController,
                                ),
                                const RegisterRoleSelector(),


                                CustomButton(
                                  isLoading: context
                                          .watch<RegisterCubit>()
                                          .state
                                          .registerState ==
                                      AuthState.loading,
                                  text: 'Register now',
                                  onPressed: () => _onRegisterPressed(context),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleRegisterState({
    required BuildContext context,
    required AuthState registerState,
  }) {
    if (registerState == AuthState.success) {
      _navigateToEmailVerification(context);
      _resetState(context);
      return;
    }

    if (registerState == AuthState.error) {
      final errorMessage = context.read<RegisterCubit>().state.error ??
          'Unknown error occurred.';
      _handleRegisterError(
        context: context,
        errorMessage: errorMessage,
      );
      _resetState(context);
    }
  }

  void _resetState(BuildContext context) => Future.microtask(
        () => context.read<RegisterCubit>().resetState(),
      );

  void _navigateToEmailVerification(BuildContext context) =>
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => AppRouter.pushNamed(context, AppRouterNames.home),
      );

  void _handleRegisterError({
    required BuildContext context,
    required String errorMessage,
  }) {
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
    final provider = context.read<RegisterCubit>();
    final errorMsg = provider.validateRegistrationInputs(
      userName: nameController.text,
      phoneNumber: phoneController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );
    if (errorMsg != null) {
      AppAlerts.showErrorSnackBar(context, errorMsg);
    } else {
      provider.register(
        name: nameController.text,phone: phoneController.text,
          email: emailController.text, password: passwordController.text);
    }
  }
}
