import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_strings/app_strings.dart';

class BookingEmptyWidget extends StatelessWidget {
  const BookingEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Center(
      child: Container(
        width: deviceSize.width * 0.94,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          AppStrings.bookingsIsEmpty,
          style: TextStyle(fontSize: 22.sp, color: Colors.black, height: 2),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
