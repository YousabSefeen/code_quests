import 'package:flutter/material.dart';
import 'package:flutter_task/core/constants/themes/app_text_styles.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../generated/assets.dart';

class NoAppointmentsAvailableWidget extends StatelessWidget {
  const NoAppointmentsAvailableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.25,
        width: MediaQuery.sizeOf(context).width * 0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            _buildLottieAnimation(),
            _buildMessageText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLottieAnimation() {
    return Expanded(
      child: Container(
        child: Lottie.asset(
          Assets.imagesNew,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildMessageText(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: Text(
          AppStrings.noAppointmentsAvailableToday,
          style: Theme.of(context).textTheme.smallOrangeMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
