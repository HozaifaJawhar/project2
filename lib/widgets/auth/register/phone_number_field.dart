import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneNumberField extends StatelessWidget {
  final String label;
  final bool isWhatsApp;
  final String? Function(String?)? validator;

  const PhoneNumberField({
    Key? key,
    required this.label,
    this.isWhatsApp = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              // Country Code Container
              Container(
                width: isPortrait ? screenWidth * 0.2 : screenWidth * 0.15,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.015,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    isPortrait ? screenHeight * 0.01 : screenHeight * 0.015,
                  ),
                  border: Border.all(color: AppColors.grey2),
                ),
                child: Center(
                  child: Text(
                    '+963',
                    style: GoogleFonts.almarai(
                      fontSize: isPortrait
                          ? screenHeight * 0.018
                          : screenHeight * 0.022,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              // Phone Number Input Field
              Expanded(
                child: SizedBox(
                  height: isPortrait ? screenHeight * 0.06 : screenHeight * 0.1,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: validator,
                    decoration: InputDecoration(
                      hintText: isWhatsApp
                          ? 'مثال: 944123456'
                          : 'مثال: 991234567',
                      hintStyle: GoogleFonts.almarai(
                        fontSize: isPortrait
                            ? screenHeight * 0.016
                            : screenHeight * 0.02,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyText,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
