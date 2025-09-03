import 'package:ammerha_volunteer/core/provider/auth/registeration_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'skill_chip_grid.dart';

class SkillsSelectionStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const SkillsSelectionStep({Key? key, required this.formKey})
    : super(key: key);

  @override
  State<SkillsSelectionStep> createState() => _SkillsSelectionStepState();
}

class _SkillsSelectionStepState extends State<SkillsSelectionStep> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RegistrationProvider>(
        context,
        listen: false,
      ).fetchRegistrationOptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, provider, child) {
        if (provider.isLoadingOptions) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              SkillChipGrid(
                skills: provider.skills,
                selectedIds: provider.registrationData.selectedSkillIds,
                onSelectionChanged: (selectedIds) {
                  provider.registrationData.selectedSkillIds = selectedIds;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
