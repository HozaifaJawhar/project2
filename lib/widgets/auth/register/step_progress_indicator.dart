import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'step_indicator.dart';
import 'step_label.dart';

class StepProgressIndicator extends StatelessWidget {
  final int currentStep;

  const StepProgressIndicator({Key? key, required this.currentStep})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primary,
                  size: screenWidth * 0.06,
                ),
              ),
              SizedBox(width: screenWidth * 0.06),
              Text(
                'التسجيل',
                style: GoogleFonts.almarai(
                  fontSize: isPortrait
                      ? screenHeight * 0.028
                      : screenWidth * 0.028,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            children: [
              // Indicators row
              LayoutBuilder(
                builder: (context, constraints) {
                  final stepWidth = constraints.maxWidth / 4;
                  return Stack(
                    children: [
                      Positioned(
                        left: stepWidth / 2,
                        right: stepWidth / 2,
                        top: screenHeight * 0.02,
                        child: Row(
                          children: List.generate(3, (index) {
                            return Expanded(
                              child: Container(
                                height: screenHeight * 0.0025,
                                color: index < currentStep
                                    ? AppColors.primary
                                    : AppColors.grey2,
                              ),
                            );
                          }),
                        ),
                      ),
                      Row(
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: stepWidth,
                            child: Center(
                              child: StepIndicator(
                                stepNumber: index + 1,
                                isActive: index <= currentStep,
                                isCompleted: index < currentStep,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: screenHeight * 0.01),
              // Labels row
              Row(
                children: List.generate(4, (index) {
                  final texts = [
                    'المعلومات\nالشخصية',
                    'معلومات\nالدخول',
                    'تحديد\nالمهارات',
                    'مجالات\nالتطوع',
                  ];
                  return Expanded(
                    child: Center(
                      child: StepLabel(
                        texts[index],
                        isActive: currentStep == index,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
