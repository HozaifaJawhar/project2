import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsSectionWidget extends StatelessWidget {
  final int opportunitiesCount;
  final int hoursCount;

  const StatsSectionWidget({
    super.key,
    required this.opportunitiesCount,
    required this.hoursCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatCard('الفرص', opportunitiesCount),
          const SizedBox(width: 12),
          _buildStatCard('الساعات', hoursCount),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int value) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value >= 0 ? value.toString() : "0",
                style: GoogleFonts.almarai(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: GoogleFonts.almarai(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
