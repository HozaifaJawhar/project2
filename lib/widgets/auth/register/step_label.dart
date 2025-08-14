import 'package:ammerha_volunteer/config/responsive/ui_helper.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepLabel extends StatelessWidget {
  final String text;
  final bool isActive; // Add this parameter

  const StepLabel(this.text, {Key? key, this.isActive = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.almarai(
        fontSize: UIHelpers.getResponsiveFontSize(context, baseSize: 12),
        color: isActive ? AppColors.primary : AppColors.greyText,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
