import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/themes/app_colors.dart';



class AdaptiveActionButton extends StatelessWidget {

  final String title;
  final bool  isButtonDisabled;
  final bool  isLoading;
  final void Function()  onPressed;

  const AdaptiveActionButton({super.key, required this.title, required this.isButtonDisabled, required this.onPressed, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 20),
    width: double.infinity,
    height: 50,
    child:    ElevatedButton(
    onPressed: isButtonDisabled ? null :   onPressed,
    style: _getButtonStyle(isButtonDisabled),
    child: isLoading
    ? const CircularProgressIndicator(color: Colors.white)
        : _buildButtonText(),
    ),

    );
  }

  /// Returns the appropriate button style based on disabled state
  ButtonStyle _getButtonStyle(bool isDisabled) {
    return ButtonStyle(
      elevation: const WidgetStatePropertyAll(1),
      backgroundColor: WidgetStatePropertyAll(
          isDisabled ? Colors.grey.shade300 : AppColors.softBlue,
      ),
      foregroundColor:
      WidgetStatePropertyAll(isDisabled ? Colors.black : Colors.white),
    );
  }

  /// Builds the text widget for the button with consistent styling
  Widget _buildButtonText() {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 19.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
