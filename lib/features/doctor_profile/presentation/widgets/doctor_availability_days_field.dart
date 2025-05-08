import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/states/doctor_profile_state.dart';
import 'doctor_info_field.dart';

class DoctorAvailabilityDaysField extends StatelessWidget {
  DoctorAvailabilityDaysField({super.key});

    final List<String> _weekDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
      selector: (state) => state.confirmedWorkingDays,
      builder: (context, confirmedDays) {
        return DoctorInfoField(
          label: 'Working Days',
        hintText: confirmedDays.isEmpty
            ? 'Select Working Days'
            : confirmedDays.join(', '),
          validator: (_) {
            if (confirmedDays.isEmpty) {
              return 'Please select at least one working day.';
            }
            return null;
          },
          maxLines: 2,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_month_outlined),
          onPressed: () => _showDaySelectionDialog(context),
        ),
        );
      },
    );
  }

  void _showDaySelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BlocSelector<DoctorProfileCubit, DoctorProfileState, List<String>>(
        selector: (state) => state.tempSelectedDays,
        builder: (context, tempDays) => AlertDialog(
          title: const Text('Select Working Days'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: _weekDays.map((day) {
                return CheckboxListTile(
                  title: Text(day),
                  value: tempDays.contains(day),
                  onChanged: (_) => context.read<DoctorProfileCubit>().toggleWorkingDay(day),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<DoctorProfileCubit>().confirmWorkingDaysSelection();
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

