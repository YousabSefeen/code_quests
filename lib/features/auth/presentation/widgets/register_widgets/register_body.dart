import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:flutter_task/features/auth/presentation/widgets/register_widgets/register_header_section.dart';

import '../../../../../core/constants/themes/app_colors.dart';
import '../../controller/cubit/register_cubit.dart';
import '../../controller/states/register_state.dart';
import '../custom_button.dart';
import '../register_form_fields.dart';
import '../register_role_selector.dart';

class RegisterBody extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onRegisterPressed;

  const RegisterBody({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const RegisterHeaderSection(),
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          child: Column(
            children: [
              RegisterFormFields(
                userNameController: nameController,
                phoneController: phoneController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
              ),
              const RegisterRoleSelector(),
              BlocSelector<RegisterCubit, RegisterState, LazyRequestState>(
                selector: (state) => state.registerState,
                builder: (context, registerState) => CustomButton(
                  text: 'Register now',
                  onPressed: onRegisterPressed,
                  isLoading: registerState == LazyRequestState.loading,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
