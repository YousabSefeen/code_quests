// core/app_alerts/app_error_dialogs.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/core/constants/app_routes/app_router.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../animations/custom_modal_type_dialog.dart';
import '../app_strings/app_strings.dart';
import '../themes/app_colors.dart';

class AppErrorDialogs {
  static void showErrorModal({
    required BuildContext context,
    required String errorMessage,
  }) {
    WoltModalSheet.show(
      context: context,
      modalTypeBuilder: (_) => MyCustomModalTypeDialog(),
      barrierDismissible: true,
      pageListBuilder: (_) => [
        WoltModalSheetPage(
          backgroundColor: Colors.white,
          hasSabGradient: false,
          topBarTitle: const SizedBox.shrink(),
          topBar: _buildTopBar(context),
          navBarHeight: 130,

          child: _buildErrorBody(context, errorMessage),
          stickyActionBar: _buildTryAgainButton(context),
          isTopBarLayerAlwaysVisible: true,

        )
      ],
      onModalDismissedWithBarrierTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  static Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      color: AppColors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25.r,
            child: FaIcon(FontAwesomeIcons.xmark,
                size: 40.sp, color: AppColors.red),
          ),
          const SizedBox(height: 10),
          FittedBox(
            child: Text(
              AppStrings.oops,
              style: Theme.of(context)
                  .textTheme
                  .dialogTitleStyle
                  .copyWith(fontSize: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
  static Widget _buildErrorBody(BuildContext context, String errorMessage) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 100, left: 8, right: 8),
      child: RichText(
        text: TextSpan(
          text: 'Error Message: ',
          style:TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black
          ),
          children: [
            TextSpan(
              text: errorMessage,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
  static Widget _buildTryAgainButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => AppRouter.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(AppStrings.tryAgain),
      ),
    );
  }


}
