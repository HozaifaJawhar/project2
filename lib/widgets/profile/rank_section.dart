import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/helper/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankSectionWidget extends StatelessWidget {
  final String rankName;
  final String rankProgress;

  const RankSectionWidget({
    super.key,
    required this.rankName,
    required this.rankProgress,
  });

  @override
  Widget build(BuildContext context) {
    const Map<String, double> rankProgressMap = {
      "المتطوع البرونزي": 0.2,
      "المتطوع الفضي": 0.4,
      "المتطوع الذهبي": 0.6,
      "المتطوع الماسي": 0.8,
      "المتطوع البلاتيني": 1.0,
    };

    final double progress = rankProgressMap[rankName] ?? 0.0;
    final int percentage = (progress * 100).toInt();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 0,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    RankUtils.medalAsset(rankName),
                    width: 37,
                    height: 37,
                    fit: BoxFit.cover,
                  ),
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
                        rankName.isNotEmpty ? rankName : "غير محددة",
                        style: GoogleFonts.almarai(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
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
