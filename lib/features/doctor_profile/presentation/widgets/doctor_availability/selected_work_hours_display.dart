import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/app_strings/app_strings.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:time_range/time_range.dart';

import '../../../../../core/animations/animated_fade_transition.dart';
import '../../controller/cubit/doctor_profile_cubit.dart';
import '../../controller/states/doctor_profile_state.dart';

class SelectedWorkHoursDisplay extends StatelessWidget {
  const SelectedWorkHoursDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState,
        TimeRangeResult?>(
      selector: (state) =>
        state.confirmWorkHoursRange,
      builder: (context, workHoursRange) => AnimatedFadeTransition(



        child: Row(
          spacing: 25,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTimeText(context, AppStrings.from,workHoursRange?.start.format(context)?? 'No'),
            _buildTimeText(context, AppStrings.to, workHoursRange?.end.format(context)?? 'No'),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeText(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: '$label:',
          style: textTheme.styleField.copyWith(
            color: const Color(0xff3A59D1),
            letterSpacing: 1.3,
          ),
        ),
        TextSpan(
          text: ' $value',
          style: textTheme.numbersStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ]),
    );
  }
}
