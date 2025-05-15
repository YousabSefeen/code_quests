import 'package:flutter/cupertino.dart';
import 'package:flutter_task/core/base/disposable.dart';

class LoginControllers implements Disposable {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
