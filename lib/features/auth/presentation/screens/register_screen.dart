import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/features/auth/presentation/widgets/auth_screen_background.dart';

import '../controller/form_controllers/register_controllers.dart';
import '../widgets/register_widgets/register_screen_body.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterControllers _registerControllers;

  @override
  void initState() {
    super.initState();
    _registerControllers = RegisterControllers();
  }

  @override
  void dispose() {
    _registerControllers.dispose();
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const AuthScreenBackground(),
              RegisterScreenBody(registerControllers: _registerControllers),
            ],
          ),
        ),
      ),
    );
  }
}
