import 'package:ammerha_volunteer/config/responsive/ui_helper.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationButtons extends StatelessWidget {
  final int currentStep;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const NavigationButtons({
    Key? key,
    required this.currentStep,
    required this.onNext,
    required this.onPrevious,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.grey2),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'الرجوع',
                  style: GoogleFonts.almarai(
                    color: AppColors.greyText,
                    fontSize: UIHelpers.getResponsiveFontSize(
                      context,
                      baseSize: 16,
                    ),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          if (currentStep > 0) SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: currentStep < 3
                  ? onNext
                  : () => _showSuccessDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                currentStep < 3 ? 'المتابعة' : 'إنهاء',
                style: GoogleFonts.almarai(
                  color: AppColors.white,
                  fontSize: UIHelpers.getResponsiveFontSize(
                    context,
                    baseSize: 16,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 40),
                ),
                SizedBox(height: 20),
                Text(
                  'تم إرسال بياناتك للمشرف وسيتم إرسال رسالة على بريدك الإلكتروني لتحديد موعد المقابلة',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.almarai(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'تم',
                    style: GoogleFonts.almarai(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
