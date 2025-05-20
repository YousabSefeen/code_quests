import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_colors.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';

import '../controller/cubit/appointment_cubit.dart';
import '../controller/states/appointment_state.dart';

class AvailableDoctorTimeSlotsGrid extends StatelessWidget {
  const AvailableDoctorTimeSlotsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return BlocSelector<AppointmentCubit, AppointmentState,
        Tuple2<String?, List<String>>>(
      // selector: (state) => state.availableDoctorTimeSlots,
      selector: (state) =>
          Tuple2(state.selectedTimeByUser, state.availableDoctorTimeSlots),
      builder: (context, values) => Container(
        height: deviceHeight * 0.15,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.customWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.only(right: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 47,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: values.value2.length,
          itemBuilder: (context, index) {
            final time = values.value2[index];

            final isSelected = values.value1 == values.value2[index];

            return TimeSlotItem(
              time: time,
              isSelected: isSelected,
              onTap: () => context.read<AppointmentCubit>().setUserTime(time),
            );
          },
        ),
      ),
    );
  }
}

class TimeSlotItem extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotItem({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: Text(
          time,
          style: Theme.of(context).textTheme.mediumBlackBold.copyWith(
                fontSize: 13.sp,
                color: isSelected ? Colors.white : AppColors.black,
              ),
        ),
      ),
    );
  }
}
