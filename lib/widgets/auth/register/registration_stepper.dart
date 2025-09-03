import 'package:ammerha_volunteer/config/routes/app_routes.dart';
import 'package:ammerha_volunteer/core/provider/auth/registeration_provider.dart';
import 'package:ammerha_volunteer/widgets/auth/register/presonal_info_step.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact_info_step.dart';
import 'skills_selection_step.dart';
import 'interests_selection_step.dart';
import 'step_progress_indicator.dart';

class RegistrationStepper extends StatefulWidget {
  const RegistrationStepper({super.key});

  @override
  State<RegistrationStepper> createState() => _RegistrationStepperState();
}

class _RegistrationStepperState extends State<RegistrationStepper> {
  final PageController _pageController = PageController();
  final List<GlobalKey<FormState>> _formKeys = List.generate(
    4,
    (_) => GlobalKey<FormState>(),
  );

  // Controllers for all text fields across steps
  late TextEditingController _fullNameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _phoneController;
  late TextEditingController _whatsappController;
  late TextEditingController _facebookController;
  late TextEditingController _instagramController;

  @override
  void initState() {
    super.initState();
    final regData = Provider.of<RegistrationProvider>(
      context,
      listen: false,
    ).registrationData;

    // Initialize controllers with data from provider (to preserve state)
    _fullNameController = TextEditingController(text: regData.fullName);
    _addressController = TextEditingController(text: regData.address);
    _emailController = TextEditingController(text: regData.email);
    _passwordController = TextEditingController(text: regData.password);
    _confirmPasswordController = TextEditingController();
    _phoneController = TextEditingController(text: regData.phone);
    _whatsappController = TextEditingController(text: regData.whatsapp);
    _facebookController = TextEditingController(text: regData.facebook);
    _instagramController = TextEditingController(text: regData.instagram);
  }

  @override
  void dispose() {
    // Dispose all controllers to prevent memory leaks
    _pageController.dispose();
    _fullNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _whatsappController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  // Saves data from the current step's controllers into the provider
  void _saveCurrentStepData(RegistrationProvider provider) {
    final data = provider.registrationData;
    switch (provider.currentStep) {
      case 0:
        data.fullName = _fullNameController.text.trim();
        data.address = _addressController.text.trim();
        // TODO: Save other fields from step 1 (gender, birthdate, image)
        break;
      case 1:
        data.email = _emailController.text.trim();
        data.password = _passwordController.text.trim();
        data.phone = _phoneController.text.trim();
        data.whatsapp = _whatsappController.text.trim();
        data.facebook = _facebookController.text.trim();
        data.instagram = _instagramController.text.trim();
        break;
      // Step 3 (Skills) and 4 (Interests) data is saved directly from their widgets
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, regProvider, child) {
        // Animate to the correct page when the step in the provider changes
        if (_pageController.hasClients &&
            _pageController.page?.round() != regProvider.currentStep) {
          _pageController.animateToPage(
            regProvider.currentStep,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }

        return Column(
          children: [
            StepProgressIndicator(currentStep: regProvider.currentStep),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable manual swiping
                children: [
                  PersonalInfoStep(
                    formKey: _formKeys[0],
                    fullNameController: _fullNameController,
                    addressController: _addressController,
                  ),
                  ContactInfoStep(
                    formKey: _formKeys[1],
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    phoneController: _phoneController,
                    whatsappController: _whatsappController,
                    facebookController: _facebookController,
                    instagramController: _instagramController,
                  ),
                  SkillsSelectionStep(formKey: _formKeys[2]),
                  InterestsSelectionStep(formKey: _formKeys[3]),
                ],
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Show "Back" button only if not on the first step
                  if (regProvider.currentStep > 0)
                    TextButton(
                      onPressed: regProvider.isSubmitting
                          ? null
                          : regProvider.previousStep,
                      child: const Text('السابق'),
                    ),

                  // Spacer to push the "Next" button to the end if "Back" is not visible
                  if (regProvider.currentStep == 0) const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    onPressed: regProvider.isSubmitting
                        ? null
                        : () async {
                            // 1. Validate the current step's form
                            if (_formKeys[regProvider.currentStep].currentState!
                                .validate()) {
                              // 2. Save data from the current step's controllers to the provider
                              _saveCurrentStepData(regProvider);

                              // 3. If moving to the skills step, fetch options from the API
                              if (regProvider.currentStep == 1) {
                                // Moving from step 2 to 3
                                await regProvider.fetchRegistrationOptions();
                              }

                              // 4. Check if it's the final step or not
                              if (regProvider.currentStep < 3) {
                                regProvider.nextStep();
                              } else {
                                // Final step: Handle the submission process
                                final success = await regProvider
                                    .submitRegistration();
                                if (success && mounted) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.loginRoute,
                                    (route) => false,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('تم إنشاء الحساب بنجاح!'),
                                    ),
                                  );
                                } else if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'فشل إنشاء الحساب، يرجى المحاولة مرة أخرى.',
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                    child: regProvider.isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            regProvider.currentStep < 3
                                ? 'التالي'
                                : 'إنشاء حساب',
                          ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
