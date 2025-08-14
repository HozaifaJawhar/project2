import 'package:flutter/material.dart';

import 'skill_chip_grid.dart';

class SkillsSelectionStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SkillsSelectionStep({Key? key, required this.formKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 40),
          SkillChipGrid(
            skills: [
              'المونتاج',
              'التصوير',
              'التصميم الجرافيكي',
              'العمل الميداني',
              'البرمجة',
              'التسويق',
              'التعليم',
              'إدارة المخزون وتجهيز المستودعات',
              'التعامل مع الأطفال',
              'التمريض',
              'الدعم التقني',
              'إدارة المشاريع',
              'تنظيم الفعاليات',
              'مهارات التواصل',
            ],
          ),
        ],
      ),
    );
  }
}
