import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/models/volunteer.dart';
import 'package:ammerha_volunteer/widgets/honorBaord/rank_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankSectionWidget extends StatelessWidget {
  final String rankName;
  final double rankProgress;
  final RankTier rankTier;

  const RankSectionWidget({
    super.key,
    required this.rankName,
    required this.rankProgress,
    required this.rankTier,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (rankProgress * 100).toInt();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  getRankBadgeWidget(rankTier, size: 40),
                  //Image.asset(badgeAssetPath, width: 40, height: 40),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رتبة التطوع',
                        style: GoogleFonts.almarai(
                          color: AppColors.greyText,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        rankName,
                        style: GoogleFonts.almarai(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: rankProgress,
                backgroundColor: Colors.grey.shade300,
                color: AppColors.primary,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$percentage%',
                  style: GoogleFonts.almarai(
                    color: AppColors.greyText,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
