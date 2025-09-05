import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/models/event.dart';
import 'package:ammerha_volunteer/screens/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OpportunityCard extends StatelessWidget {
  final Eventt event;

  const OpportunityCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = event.date != null
        ? DateFormat('yyyy-MM-dd').format(event.date!)
        : 'بدون تاريخ';
    final String departmentName = event.department?.name ?? 'بدون قسم';
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Card(
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // صورة الفعالية
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: _EventCoverImage(url: event.coverImage?.file),
              ),
              const SizedBox(width: 12),
              // معلومات الفعالية
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      departmentName,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        text: '${event.volunteersCount} متطوع   ',
                        style: const TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: '${event.acceptedCount} متطوع تم قبولهم',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventCoverImage extends StatelessWidget {
  final String? url;
  const _EventCoverImage({required this.url});

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      // صورة افتراضية من الأصول لو ما في URL
      return const Image(
        image: AssetImage('assets/images/event_image.jpg'),
        width: 75,
        height: 75,
        fit: BoxFit.cover,
      );
    }

    return Image.network(
      url!,
      width: 75,
      height: 75,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Image(
        image: AssetImage('assets/images/event_image.jpg'),
        width: 75,
        height: 75,
        fit: BoxFit.cover,
      ),
      // بإمكانك إضافة loadingBuilder إن حبيت
    );
  }
}
