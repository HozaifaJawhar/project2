import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepIndicator extends StatelessWidget {
  final int stepNumber;
  final bool isActive;
  final bool isCompleted;

  const StepIndicator({
    Key? key,
    required this.stepNumber,
    required this.isActive,
    required this.isCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final indicatorSize = isPortrait ? screenHeight * 0.04 : screenWidth * 0.04;

    return Container(
      width: indicatorSize * 1.6, // 52 equivalent
      height: indicatorSize, // 32 equivalent
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted || isActive ? AppColors.primary : AppColors.grey2,
      ),
      child: Center(
        child: isCompleted
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: indicatorSize * 0.5, // 16 equivalent
              )
            : Text(
                stepNumber.toString(),
                style: GoogleFonts.almarai(
                  color: isActive ? Colors.white : AppColors.greyText,
                  fontWeight: FontWeight.bold,
                  fontSize: indicatorSize * 0.44, // 14 equivalent
                ),
              ),
      ),
    );
  }
}
