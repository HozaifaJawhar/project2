import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'custom_password_text_field.dart';
import 'custom_text_field.dart';
import 'phone_number_field.dart';

class ContactInfoStep extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController facebookController;
  final TextEditingController instagramController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final TextEditingController whatsappController;

  const ContactInfoStep({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.facebookController,
    required this.instagramController,
    required this.confirmPasswordController,
    required this.passwordController,
    required this.phoneController,
    required this.whatsappController,
  }) : super(key: key);

  @override
  _ContactInfoStepState createState() => _ContactInfoStepState();
}

class _ContactInfoStepState extends State<ContactInfoStep> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  String? _password;

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
        key: widget.formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: widget.emailController,
              label: 'البريد الإلكتروني',
              placeholder: 'أدخل بريدك الإلكتروني',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'هذا الحقل مطلوب';
                if (!EmailValidator.validate(value!)) {
                  return 'بريد إلكتروني غير صالح';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomPasswordTextField(
              label: 'كلمة المرور',
              placeholder: 'أدخل كلمة المرور',
              obscureText: _obscureText,
              onVisibilityToggle: () {
                setState(() => _obscureText = !_obscureText);
              },
              validator: (value) {
                if (value?.isEmpty ?? true) return 'هذا الحقل مطلوب';
                if (value!.length < 8) return 'يجب أن تكون 8 أحرف على الأقل';
                _password = value;
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomPasswordTextField(
              label: 'تأكيد كلمة المرور',
              placeholder: 'أعد كتابة كلمة المرور',
              obscureText: _obscureConfirmText,
              onVisibilityToggle: () {
                setState(() => _obscureConfirmText = !_obscureConfirmText);
              },
              validator: (value) {
                if (value != _password) return 'كلمة المرور غير متطابقة';
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            PhoneNumberField(
              label: 'رقم الهاتف',
              validator: (value) {
                if (value?.isEmpty ?? true) return 'هذا الحقل مطلوب';
                if (value!.length < 9)
                  return 'رقم هاتف غير صالح, على الاقل 9 خانات';
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            PhoneNumberField(
              label: 'رقم الواتساب',
              isWhatsApp: true,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'هذا الحقل مطلوب';
                if (value!.length < 9)
                  return 'رقم واتساب غير صالح, على الاقل 9 خانات';
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
              controller: widget.facebookController,
              label: 'رابط الفيسبوك (اختياري)',
              placeholder: 'أدخل رابط حسابك الشخصي على فيسبوك',
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
              controller: widget.instagramController,
              label: 'رابط الانستغرام (اختياري)',
              placeholder: 'أدخل رابط حسابك الشخصي على انستغرام',
            ),
          ],
        ),
      ),
    );
  }
}
