import 'package:flutter/material.dart';

import 'check_box_tile.dart';
import 'custom_date_picker.dart';
import 'custom_drop_down.dart';
import 'custom_text_field.dart';
import 'profile_image_picker.dart';

class PersonalInfoStep extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const PersonalInfoStep({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ProfileImagePicker(),
            SizedBox(height: screenHeight * 0.015),
            CustomTextField(
              label: 'الاسم الثلاثي',
              placeholder: 'أدخل اسمك الثلاثي',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
            SizedBox(height: screenHeight * 0.02),
            // CustomTextField(
            //   label: 'الجنسية',
            //   placeholder: 'أدخل جنسيتك',
            //   validator: (value) => value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            // ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
              label: 'العنوان',
              placeholder: 'أدخل عنوانك الكامل',
              validator: (value) =>
                  value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomDropdown(label: 'الجنس', value: 'ذكر'),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: CustomDatePicker(
                    label: 'تاريخ الميلاد',
                    placeholder: 'أدخل تاريخ ميلادك',
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            CheckboxTile(text: 'الموافقة على اتفاقية العمل التطوعي'),
          ],
        ),
      ),
    );
  }
}
