import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/app_alerts/no_internet_dialog.dart';

import 'error_dialogs.dart';
import 'widgets/app_alert_widgets.dart';

class AppAlerts {
  static void showErrorSnackBar(BuildContext context, String errorMessage) {
  //  ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      AppAlertWidgets.errorSnackBar(errorMessage),
    );
  }

  static void showRegisterErrorSnackBar({
    required BuildContext context,
    required Widget content,
    required String errorMessage,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      AppAlertWidgets.registerSnackBar(
        content: content,
        errorMessage: errorMessage,
      ),
    );
  }

  static void customDialog({
    required BuildContext context,
    required Widget body,
  }) =>
      showDialog(
        context: context,
      builder: (context) => body,
    );

  static void showAppointmentSuccessDialog({
    required BuildContext context,
    required String message,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: message,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, _, __) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (!context.mounted) return;
          Navigator.of(context).pop();
        });

        return Align(
          child: Material(
            color: Colors.transparent,
            child: AppAlertWidgets.successDialogContent(message),
          ),
        );
      },
      transitionBuilder: (context, animation1, _, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation1,
            curve: Curves.easeOutBack,
          ),
          child: child,
        );
      },
    );
  }

  static showNoInternetDialog(BuildContext context) =>
      NoInternetDialog.showErrorModal(context: context);

  static showErrorDialog(BuildContext context, String errorMessage) =>
      ErrorDialogs.showErrorDialog(
          context: context, errorMessage: errorMessage);
}
