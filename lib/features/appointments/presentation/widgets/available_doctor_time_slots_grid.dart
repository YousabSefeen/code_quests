import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';

import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';

class AvailableDoctorTimeSlotsGrid extends StatelessWidget {
  const AvailableDoctorTimeSlotsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.sizeOf(context).height;
    return BlocSelector<AppointmentCubit, AppointmentState, List<String>>(
      selector: (state) => state.availableDoctorTimeSlots,
      builder: (context, availableDoctorTimeSlots) => Container(
        height: deviceHeight * 0.15,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.customWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: GridView.builder(
            padding: const EdgeInsets.only(right: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 47,
              crossAxisCount: 4, // number of items in each row
              mainAxisSpacing: 8.0, // spacing between rows
              crossAxisSpacing: 8.0, // spacing between columns
            ),
            itemCount: availableDoctorTimeSlots.length,
            itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    availableDoctorTimeSlots[index],
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 13.sp,color: AppColors.darkBlue),
                  ),
                )),
      ),
    );
  }
}
