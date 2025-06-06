import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFieldContainer extends StatelessWidget {
  final Widget child;
  final FormFieldState<Object?> field;

  const CustomFieldContainer(
      {super.key, required this.child, required this.field});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: field.hasError ? Colors.red : Colors.black12,
                width: 1.2,
              )),
          child: child,
        ),
        field.hasError ? _displayErrorText() : const SizedBox(),
      ],
    );
  }

  Padding _displayErrorText() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 8),
      child: Text(
        field.errorText!,
        style: TextStyle(color: Colors.red, fontSize: 12.sp),
      ),
    );
  }
}
