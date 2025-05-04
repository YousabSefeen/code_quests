import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthDividerLabel extends StatelessWidget {
  final bool isLogin;

  const AuthDividerLabel({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${isLogin ? 'Sign in' : 'Sign up'} with',
            style: TextStyle(
                fontSize: 15.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
        _buildDivider(),
      ],
    );
  }

  Expanded _buildDivider() => Expanded(
          child: Divider(
        color: Colors.white70,
        thickness: 2,
      ));
}
