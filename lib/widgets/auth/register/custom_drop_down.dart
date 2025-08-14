import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String value;
  final String? Function(String?)? validator;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.value,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Changed from 'end' to 'start'
      children: [
        Text(
          label,
          style: GoogleFonts.almarai(
            fontSize: isPortrait ? screenHeight * 0.02 : screenHeight * 0.025,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: screenHeight * 0.004),
        SizedBox(
          height: isPortrait ? screenHeight * 0.08 : screenHeight * 0.1,
          child: DropdownButtonFormField<String>(
            value: value,
            validator: validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.grey2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.grey2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.red, width: 1.5),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: isPortrait
                    ? screenHeight * 0.02
                    : screenHeight * 0.025,
                vertical: isPortrait
                    ? screenHeight * 0.015
                    : screenHeight * 0.02,
              ),
              isDense: true,
            ),
            items: ['ذكر', 'أنثى']
                .map(
                  (item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.almarai(
                        fontSize: isPortrait
                            ? screenHeight * 0.016
                            : screenHeight * 0.02,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
