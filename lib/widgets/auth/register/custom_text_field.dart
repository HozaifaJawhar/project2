import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String placeholder;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.almarai(
            fontSize: isPortrait ? screenHeight * 0.02 : screenHeight * 0.025,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        SizedBox(
          height: isPortrait ? screenHeight * 0.08 : screenHeight * 0.1,
          child: TextFormField(
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: GoogleFonts.almarai(
                fontSize: isPortrait
                    ? screenHeight * 0.016
                    : screenHeight * 0.02,
                fontWeight: FontWeight.w500,
                color: AppColors.greyText,
              ),
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  isPortrait ? screenHeight * 0.01 : screenHeight * 0.015,
                ),
                borderSide: const BorderSide(color: AppColors.grey2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: isPortrait
                    ? screenHeight * 0.02
                    : screenHeight * 0.025,
                vertical: isPortrait
                    ? screenHeight * 0.015
                    : screenHeight * 0.02,
              ),
              suffixIcon: suffixIcon,
              isDense: true, // Reduces internal padding
            ),
          ),
        ),
      ],
    );
  }
}
