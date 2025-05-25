import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:flutter_task/core/enum/lazy_request_state.dart';
import 'package:flutter_task/features/doctor_profile/presentation/controller/states/doctor_profile_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../../../core/animations/custom_modal_type_dialog.dart';
import '../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../core/constants/app_alerts/app_error_dialogs.dart';
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
            .validateInputsAndCache(controllers),
        child: BlocSelector<DoctorProfileCubit,DoctorProfileState,  Tuple2<LazyRequestState,String?>>(

          selector: (state)=>Tuple2(state.doctorProfileState,state.doctorProfileError),
          builder: (context,values) {
            _showErrorModal( context,values.value1,values.value2);
           // _handleDoctorProfileState( context,values.value1,values.value2);
            return values.value1 == LazyRequestState.lazy
                ? Text(
                    AppStrings.saveButtonText,
                    style: Theme.of(context).textTheme.buttonStyle,
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                  );
          },
        ),
      ),
    );
  }

 void _showErrorModal( BuildContext context, LazyRequestState state,String? errorMessage){

    if(state!=LazyRequestState.error)return;
    print('SaveButton._showErrorModal');
    AppErrorDialogs.showErrorModal(context: context, errorMessage: errorMessage??'Null Error message' );

  }

  // Handles post-upload effects when profile upload succeeds:
  // - Resets Cubit states
  // - Shows success dialog
  // - Navigates to doctor list screen
  void _handleDoctorProfileState( BuildContext context, LazyRequestState state,String? errorMessage) {

    if (state != LazyRequestState.loaded) return;
    _dismissKeyboard();
    _resetCubitStatesAfterDelay(context);
    _showSuccessDialogAfterDelay(context);
    _navigateToDoctorListAfterDelay(context);
  }

  // Dismisses the keyboard if it's currently open.
  void _dismissKeyboard() => AppRouter.dismissKeyboard();

  // - Resets Cubit states
  void _resetCubitStatesAfterDelay(BuildContext context) =>
      Future.delayed(const Duration(milliseconds: 200), () {
        if (!context.mounted) return;
        context.read<DoctorProfileCubit>().resetStates();
      });

  // - Shows success dialog
  void _showSuccessDialogAfterDelay(BuildContext context) =>
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!context.mounted) return;
        AppAlerts.showAppointmentSuccessDialog(
          context: context,
          message: 'Successfully',
        );
      });

  // - Navigates to doctor list screen
  void _navigateToDoctorListAfterDelay(BuildContext context) =>
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (!context.mounted) return;
        AppRouter.pushNamedAndRemoveUntil(
          context,
          AppRouterNames.doctorListView,
        );
      });
}
