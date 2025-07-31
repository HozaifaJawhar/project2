import 'package:ammerha_volunteer/core/models/event_class.dart';
import 'package:flutter/material.dart';

class OpportunityCard extends StatelessWidget {
  final Event event;

  const OpportunityCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              child: Image.network(
                event.imageUrl,
                width: 60,
                height: 60,
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
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
