import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart';

import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_routes/app_router.dart';
import '../../../../core/constants/app_routes/app_router_names.dart';
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
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: WidgetStatePropertyAll(AppColors.softBlue),
        ),
        onPressed: () => context
              .read<DoctorProfileCubit>()
              .validateAndCacheInputs(controllers),
        child: BlocSelector<DoctorProfileCubit,DoctorProfileState, LazyRequestState>(

          selector: (state)=>state.doctorProfileState,
          builder: (context,doctorProfileState) {
            _handelState(doctorProfileState, context);
            //***
            return doctorProfileState==LazyRequestState.lazy?
        const Text(
            AppStrings.saveButtonText,
            style: TextStyle(fontSize: 20),
          ):const CircularProgressIndicator(color: Colors.white,);
          },
        ),
      ),
    );
  }

  void _handelState(LazyRequestState doctorProfileState, BuildContext context) {
    if (doctorProfileState == LazyRequestState.loaded) {
      Future.microtask(() {
        if (!context.mounted) return;
        AppAlerts.showAppointmentSuccessDialog(
          context: context,
          message: 'Successfully',
        );
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (!context.mounted) return;
          AppRouter.pushNamedAndRemoveUntil(
            context,
            AppRouterNames.doctorListView,
          );
          context.read<DoctorProfileCubit>().resetStates();
        });
      });
    }
  }

}
