import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFieldContainer extends StatelessWidget {
  final Widget child;
   final bool? isFieldHasError;
  const CustomFieldContainer({super.key, required this.child, this.isFieldHasError=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isFieldHasError!?  Colors.red:Colors.black12,
            width: 1.2,
          )),
      child: child,
    );
  }
}
