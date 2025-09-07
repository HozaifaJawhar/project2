import 'package:ammerha_volunteer/config/routes/app_routes.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/helper/utils.dart';
import 'package:ammerha_volunteer/core/models/volunteer_api_model.dart';
import 'package:ammerha_volunteer/core/models/volunteer_profile.dart';
import 'package:ammerha_volunteer/core/provider/auth/auth_provider.dart';
import 'package:ammerha_volunteer/core/provider/volunteer_provider.dart';
import 'package:ammerha_volunteer/widgets/honorBaord/rank_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Drawer(
      width: screenWidth * 0.85,
      backgroundColor: Colors.grey.shade100,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDrawerHeader(context),
              const SizedBox(height: 24),
              // _buildDrawerItem(
              //   icon: Icons.settings_outlined,
              //   text: 'الإعدادات',
              //   onTap: () {},
              // ),
              // _buildDrawerItem(
              //   icon: Icons.light_mode_outlined,
              //   text: 'المظهر',
              //   onTap: () {},
              // ),
              _buildDrawerItem(
                icon: Icons.style_outlined,
                text: 'طلب شهادة التطوع',
                onTap: () {},
              ),

              _buildDrawerItem(
                icon: Icons.info_outline,
                text: 'عن التطبيق',

                onTap: () {},
              ),
              _buildDrawerItem(
                icon: Icons.info_outline,
                text: 'حذف حسابي ',

                onTap: () {},
              ),
              // Spacer pushes the logout item to the bottom of the column.
              Spacer(),
              _buildDrawerItem(
                icon: Icons.logout,
                text: 'تسجيل الخروج',
                color: Colors.red.shade700,
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  // Go back to the login screen and delete everything
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.loginRoute,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build the drawer's header section.
  Widget _buildDrawerHeader(BuildContext context) {
    final VolunteerApiModel = context.watch<VolunteerProvider>().profile;

    if (VolunteerApiModel == null) {
      return const Center(child: CircularProgressIndicator());
    }
    Widget avatar;
    final imageUrl = VolunteerApiModel.personalImage;
    if (imageUrl != null &&
        imageUrl.isNotEmpty &&
        imageUrl.startsWith('http')) {
      avatar = CircleAvatar(
        radius: 43,
        backgroundColor: Colors.grey.shade200,
        backgroundImage: NetworkImage(imageUrl),
        onBackgroundImageError: (_, __) {
          // fallback في حال فشل تحميل الصورة من الانترنت
        },
      );
    } else {
      avatar = const CircleAvatar(
        radius: 43,
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage('assets/images/profile.png'),
      );
    }

    return Row(
      children: [
        avatar,
        const SizedBox(width: 8),
        // Expanded ensures the Column takes up the remaining available space.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Flexible allows the Text widget to shrink if needed, preventing overflow.
                  Flexible(
                    child: Text(
                      VolunteerApiModel.name,
                      style: GoogleFonts.almarai(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    RankUtils.medalAsset(VolunteerApiModel.rank), // حسب الرتبة
                    width: 37,
                    height: 37,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                VolunteerApiModel.rank,
                style: GoogleFonts.almarai(
                  color: AppColors.greyText,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method to build each item in the drawer list.
  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            child: Row(
              children: [
                Icon(icon, color: color ?? AppColors.primary, size: 26),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    text,
                    style: GoogleFonts.almarai(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: color ?? AppColors.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
