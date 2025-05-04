import 'package:flutter/material.dart';

class LoginFormWidget extends StatelessWidget {
  final Animation<Offset> slideOffset;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormWidget({
    super.key,
    required this.slideOffset,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SlideTransition(
          position: slideOffset,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff7C93C3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                // _buildInputField("Email or Phone number", obscure: false),
                // _buildInputField("Password", obscure: true),
                // CustomFormField(hint: 'Email', controller: emailController  ,),
                // Divider(
                //   color: Colors.white,
                // ),
                // CustomFormField(hint: 'Password', controller:  passwordController,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
