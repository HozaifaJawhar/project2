import 'package:ammerha_volunteer/config/responsive/ui_helper.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/widgets/auth/password_field.dart';
import 'package:ammerha_volunteer/widgets/auth/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  bool _rememberMe = false;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // in column ---> we focus in screenHeight when we use mediaQuery
    // in row ---> we focus in screenWidth when we use mediaQuery
    final screenHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/logos/logo1.png',
                  height: screenHeight * 0.27,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'تسجيل الدخول',
                    style: GoogleFonts.almarai(
                      fontSize: UIHelpers.getResponsiveFontSize(
                        context,
                        baseSize: 22,
                      ),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'البريد الإلكتروني',
                    style: GoogleFonts.almarai(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                CustomdField(
                  controller: _emailController,
                  hintText: 'أدخل البريد الإلكتروني',
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'كلمة المرور',
                    style: GoogleFonts.almarai(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                CustomPasswordField(
                  controller: _passwordController,
                  hintText: 'أدخل كلمة المرور',
                  obscureText: _obscureText,
                  onVisibilityToggle: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: GoogleFonts.almarai(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          side: BorderSide(color: AppColors.greyText),
                          onChanged: (val) =>
                              setState(() => _rememberMe = val!),
                        ),
                        Text(
                          'تذكرني',
                          style: GoogleFonts.almarai(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.almarai(
                        fontSize: UIHelpers.getResponsiveFontSize(
                          context,
                          baseSize: 16,
                        ),
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'أليس لديك حساب؟ ',
                    style: GoogleFonts.almarai(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(
                        text: 'سجل كمتطوع جديد',
                        style: GoogleFonts.almarai(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//kuhukhkuh