import 'package:ammerha_volunteer/core/provider/auth/registeration_provider.dart';
import 'package:ammerha_volunteer/widgets/auth/register/registration_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme/app_theme.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ChangeNotifierProvider(
        create: (_) => RegistrationProvider(),
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(child: RegistrationStepper()),
        ),
      ),
    );
  }
}
