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
          _buildStatCard('الفرص', opportunitiesCount.toString()),
          const SizedBox(width: 12),
          _buildStatCard('الساعات', hoursCount.toString()),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Text(
                value,
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
                  fontSize: 12,
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
