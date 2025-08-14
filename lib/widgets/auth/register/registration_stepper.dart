import 'package:flutter/material.dart';
import 'contact_info_step.dart';
import 'interests_selection_step.dart';
import 'navigation_buttons.dart';
import 'presonal_info_step.dart';
import 'skills_selection_step.dart';
import 'step_progress_indicator.dart';

class RegistrationStepper extends StatefulWidget {
  @override
  _RegistrationStepperState createState() => _RegistrationStepperState();
}

class _RegistrationStepperState extends State<RegistrationStepper> {
  int currentStep = 0;
  PageController _pageController = PageController();
  final List<GlobalKey<FormState>> formKeys = List.generate(4, (_) => GlobalKey<FormState>());

  void nextStep() {
    // Only validate for steps that have forms (0 and 1)
    if (currentStep < 2) {
      if (!(formKeys[currentStep].currentState?.validate() ?? false)) {
        return;
      }
    }

    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepProgressIndicator(currentStep: currentStep),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(), // Prevent manual swiping
            onPageChanged: (index) {
              setState(() {
                currentStep = index;
              });
            },
            children: [
              PersonalInfoStep(formKey: formKeys[0]),
              ContactInfoStep(formKey: formKeys[1]),
              SkillsSelectionStep(formKey: formKeys[2]),
              InterestsSelectionStep(formKey: formKeys[3]),
            ],
          ),
        ),
        NavigationButtons(
          currentStep: currentStep,
          onNext: nextStep,
          onPrevious: previousStep,
        ),
      ],
    );
  }
}