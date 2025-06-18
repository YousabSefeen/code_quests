import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/appointments/presentation/controller/states/appointment_state.dart';

import '../../../../../core/constants/app_alerts/app_alerts.dart';
import '../../../../../core/constants/app_alerts/no_internet_dialog.dart';
import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/constants/app_strings/app_strings.dart';
import '../../../../../core/enum/lazy_request_state.dart';
import '../../controller/cubit/appointment_cubit.dart';
import '../../controller/form_contollers/patient_fields_controllers.dart';
import '../../controller/states/appointment_action_state.dart';
import '../custom_widgets/adaptive_action_button.dart';

class PayNowButton extends StatelessWidget {
  final String doctorId;
  final PatientFieldsControllers formControllers;

  const PayNowButton(
      {super.key, required this.doctorId, required this.formControllers});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppointmentCubit, AppointmentState,
        Tuple2<LazyRequestState, String>>(
      selector: (state) =>
          Tuple2(state.bookAppointmentState, state.bookAppointmentError),
      builder: (context, values) => AdaptiveActionButton(
        title: AppStrings.payNow,
        isButtonDisabled: values.value1==LazyRequestState.loading,
        isLoading: false,
        onPressed: () => _validateAndSubmit(context),
      ),
    );
  }

  void _validateAndSubmit(BuildContext context) {

    context.read<AppointmentCubit>().validateInputsAndCache(
        doctorId: doctorId, controllers: formControllers);
  }

  /// Handles different states of appointment booking process
  /// Routes to appropriate handlers based on current state
  void _handleAppointmentResponse(
      BuildContext context, AppointmentActionState appointmentData) {
    switch (appointmentData.actionState) {
      case LazyRequestState.error:
        _handleBookingError(context, appointmentData.actionError);
        break;
      case LazyRequestState.loaded:
        _handleBookingSuccess(context);
        break;
      case LazyRequestState.loading:
      case LazyRequestState.lazy:
        break;
    }
  }

  /// Handles error state after failed booking attempt
  /// Shows appropriate error dialog based on error type
  /// Resets booking state after showing error
  void _handleBookingError(BuildContext context, String errorMessage) {
    Future.microtask(() {
      if (!context.mounted) return;

      if (errorMessage == AppStrings.noInternetConnection) {
        NoInternetDialog.showErrorModal(context: context);
      } else {
        AppAlerts.showErrorDialog(
            context, AppStrings.kNoInternetBookingErrorMessage);
      }

      _resetBookingState(context);
    });
  }

  /// Handles successful booking completion
  /// Shows success dialog, navigates to doctor list after delay
  /// Clears current appointment data
  void _handleBookingSuccess(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSuccessDialog(context);

      Future.delayed(const Duration(milliseconds: 700), () {
        if (!context.mounted) return;
        _navigateToDoctorList(context);
      });

      _resetBookingState(context);
    });

/*    final appointmentDate =
        context.read<AppointmentCubit>().selectedDateFormatted;
    final appointmentTime = context.read<AppointmentCubit>().selectedTimeSlot;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppAlerts.showAppointmentSuccessDialogX(
        context: context,
        onViewAppointmentPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => AppointmentDetailsScreen(
                doctorModel: doctorModel,
                appointmentDate: appointmentDate,
                appointmentTime: appointmentTime,
              )));

        },
        onCancelPressed: () => AppRouter.pop(context),
      );
    });*/
  }

  /// Displays success dialog after booking confirmation
  void _showSuccessDialog(BuildContext context) =>
      AppAlerts.showAppointmentSuccessDialog(
        context: context,
        message: AppStrings.successMessage,
      );

  /// Navigates back to doctor list screen and removes all previous routes
  // void _navigateToDoctorList(BuildContext context) =>
  //     AppRouter.pushNamedAndRemoveUntil(
  //       context,
  //       AppRouterNames.doctorListView,
  //     );
  void _navigateToDoctorList(BuildContext context) => AppRouter.pop(context);

  /// Resets booking state to initial values in cubit
  void _resetBookingState(BuildContext context) =>
      context.read<AppointmentCubit>().resetBookAppointmentState();
}
