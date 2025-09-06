import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/helper/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankSectionWidget extends StatelessWidget {
  final String rankName; // مثل: "المتطوع البرونزي"
  final String rankProgress; // جاي من الـ API كسلسلة (مثال: "0.35" أو "35%")

  const RankSectionWidget({
    super.key,
    required this.rankName,
    required this.rankProgress,
  });

  @override
  Widget build(BuildContext context) {
    // نحاول نقرأ progress من النص ونحوّله لـ double
    double safeProgress = 0.0;

    try {
      String cleaned = rankProgress.replaceAll("%", "").trim();
      double value = double.tryParse(cleaned) ?? 0.0;

      // إذا القيمة أكبر من 1 معناها جايه كنسبة (35 => 0.35)
      if (value > 1) {
        safeProgress = value / 100;
      } else {
        safeProgress = value;
      }
    } catch (_) {
      safeProgress = 0.0;
    }

    final percentage = (safeProgress * 100).toInt();

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
                    RankUtils.medalAsset(rankName), // حسب الرتبة
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
                value: safeProgress,
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
