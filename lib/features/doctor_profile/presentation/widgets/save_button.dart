import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../controller/cubit/doctor_profile_cubit.dart';
import '../controller/form_controllers/doctor_profile_controllers.dart';

class SaveButton extends StatelessWidget {
  final DoctorProfileControllers controllers;

  const SaveButton({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        //  backgroundColor: MaterialStateProperty.all(AppColors.green),
          backgroundColor: MaterialStateProperty.all(AppColors.softBlue),
        ),
        onPressed: () {
           context
              .read<DoctorProfileCubit>().pp();




        },
        child: const Text(
          AppStrings.saveButtonText,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

}
