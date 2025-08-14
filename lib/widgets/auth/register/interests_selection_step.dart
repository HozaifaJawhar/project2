import 'package:flutter/material.dart';

import 'skill_chip_grid.dart';

class InterestsSelectionStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const InterestsSelectionStep({Key? key, required this.formKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 40),
          SkillChipGrid(
            skills: [
              'الإعلام',
              'التدريب والتطوير',
              'دعم الشباب',
              'المجال القانوني',
              'المجال التقني',
              'المجال اللوجستي',
              'حماية الطفل',
              'المجال الطبي',
              'علاقات عامة',
              'تمكين المرأة',
            ],
          ),
        ],
      ),
    );
  }
}