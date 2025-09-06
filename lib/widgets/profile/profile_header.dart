import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final int id;
  final String? imageUrl;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.id,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Widget avatar;

    if (imageUrl != null &&
        imageUrl!.isNotEmpty &&
        imageUrl!.startsWith('http')) {
      // صورة من الإنترنت
      avatar = CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: NetworkImage(imageUrl!),
        onBackgroundImageError: (_, __) {
          // في حالة فشل تحميل الصورة
        },
      );
    } else {
      // صورة افتراضية
      avatar = CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: AssetImage('assets/images/default_avatar.png'),
      );
    }

    return Column(
      children: [
        avatar,
        const SizedBox(height: 12),
        Text(
          (name.isNotEmpty) ? name : "مستخدم جديد",
          style: GoogleFonts.almarai(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'المتطوع رقم #$id',
          style: GoogleFonts.almarai(fontSize: 14, color: AppColors.greyText),
        ),
      ],
    );
  }
}
