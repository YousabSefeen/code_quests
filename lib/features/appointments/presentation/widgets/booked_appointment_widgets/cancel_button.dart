

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings/app_strings.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
      return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
        foregroundColor: const WidgetStatePropertyAll(Colors.black),
      ),
      onPressed: () {},
      child: const Text(AppStrings.cancel),
    );
  }
}
