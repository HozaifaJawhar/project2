import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/models/event_class.dart';
import 'package:ammerha_volunteer/screens/event_details_screen.dart';
import 'package:flutter/material.dart';

class OpportunityCard extends StatelessWidget {
  final Event event;

  const OpportunityCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
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
                child: Image(
                  image: AssetImage(event.imageUrl),
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // معلومات الفعالية
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      event.category,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        text: '${event.totalVolunteers} متطوع   ',
                        style: const TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: '${event.joinedVolunteers} متطوع تم قبولهم',
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
