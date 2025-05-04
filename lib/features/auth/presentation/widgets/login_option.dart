import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage(name),
          width: 30,
        ),
      ),
    );
  }
}
