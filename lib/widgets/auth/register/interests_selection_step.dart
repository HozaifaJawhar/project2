import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/provider/auth/registeration_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestsSelectionStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const InterestsSelectionStep({Key? key, required this.formKey})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingOptions) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: provider.departments.length,
          itemBuilder: (context, index) {
            final department = provider.departments[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      provider.registrationData.selectedDepartmentId ==
                          department.id
                      ? AppColors.primary
                      : Colors.grey.shade200,
                  width: 1.5,
                ),
              ),
              child: RadioListTile<int>(
                title: Text(
                  department.name,
                  style: GoogleFonts.almarai(fontWeight: FontWeight.w600),
                ),
                value: department.id,
                groupValue: provider.registrationData.selectedDepartmentId,
                onChanged: (selectedId) {
                  if (selectedId != null) {
                    provider.selectDepartment(selectedId);
                  }
                },
                activeColor: AppColors.primary,
              ),
            );
          },
        );
      },
    );
  }
}
