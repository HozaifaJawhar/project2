import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String id;
  final String imageUrl;

  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.id,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final ImageProvider backgroundImage;

    if (imageUrl.startsWith('http')) {
      backgroundImage = NetworkImage(imageUrl);
    } else {
      backgroundImage = AssetImage(
        imageUrl.isNotEmpty ? imageUrl : 'assets/images/default_avatar.png',
      );
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: backgroundImage,
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: GoogleFonts.almarai(fontSize: 22, fontWeight: FontWeight.bold),
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
