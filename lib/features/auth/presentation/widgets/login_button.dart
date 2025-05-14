import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/enum/lazy_request_state.dart';
import '../controller/cubit/login_cubit.dart';
import '../controller/states/login_state.dart';
import 'custom_button.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, LazyRequestState>(
        selector: (state) => state.loginStatus,
        builder: (context, loginStatus) {
          _handleLoginState(context, loginStatus);
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: CustomButton(
              isLoading: loginStatus == LazyRequestState.loading,
              text: 'Login',
              onPressed: () => _onLoginPressed(context),
            ),
          );
        });
  }

  void _onLoginPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    final cubit = context.read<LoginCubit>();
    final error = cubit.validateLoginInput(
      emailController.text,
      passwordController.text,
    );

    if (error != null) {
      AppAlerts.showErrorSnackBar(context, error);
    } else {
      cubit.login(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  void _handleLoginState(BuildContext context, LazyRequestState loginStatus) {
    if (!context.mounted) return;

    Future.microtask(() {
      if (context.mounted) {
        if (loginStatus == LazyRequestState.loaded) {
          AppRouter.pushNamedAndRemoveUntil(
            context,
            AppRouterNames.doctorListView,
          );
          context.read<LoginCubit>().resetState();
        } else if (loginStatus == LazyRequestState.error) {
          AppAlerts.showErrorSnackBar(
            context,
            'Unknown error occurred.',
          );
        }
        context.read<LoginCubit>().resetState();
      }
    });
  }
}
