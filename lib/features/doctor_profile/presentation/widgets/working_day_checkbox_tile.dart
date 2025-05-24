import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';

import '../controller/cubit/doctor_profile_cubit.dart';

class WorkingDayCheckboxTile extends StatelessWidget {
  final String day;
  final bool isSelected;

  const WorkingDayCheckboxTile(
      {super.key, required this.day, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      fillColor: WidgetStatePropertyAll(
        isSelected ? Colors.green : Colors.grey.shade50,
      ),
      checkColor: Colors.white,
      side: const BorderSide(color: Colors.black38),
      checkboxScaleFactor: 1.3,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      title: Text(
        day,
        style: Theme.of(context).textTheme.mediumBlackBold.copyWith(
              letterSpacing: 0.5,
              color: Colors.black87,
            ),
      ),
      value: isSelected,
      onChanged: (_) =>
          context.read<DoctorProfileCubit>().toggleWorkingDay(day),
    );
  }
}
