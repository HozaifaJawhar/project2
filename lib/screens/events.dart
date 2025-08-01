import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/models/event_class.dart';
import 'package:ammerha_volunteer/widgets/events/event_card.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final String name = "ميسان";

  final String image = "assets/images/level1(2).jpg";
  final List<Event> events = [
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '١ أغسطس ٢٠٢٥',
      category: 'صحي',
      title: 'فعالية التبرع بالدم',
      totalVolunteers: 50,
      joinedVolunteers: 20,
    ),
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '٥ أغسطس ٢٠٢٥',
      category: 'ثقافي',
      title: 'مساعدة في معرض الكتاب',
      totalVolunteers: 30,
      joinedVolunteers: 15,
    ),
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '٥ أغسطس ٢٠٢٥',
      category: 'ثقافي',
      title: 'مساعدة في معرض الكتاب',
      totalVolunteers: 30,
      joinedVolunteers: 15,
    ),
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '٥ أغسطس ٢٠٢٥',
      category: 'ثقافي',
      title: 'مساعدة في معرض الكتاب',
      totalVolunteers: 30,
      joinedVolunteers: 15,
    ),
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '٥ أغسطس ٢٠٢٥',
      category: 'ثقافي',
      title: 'مساعدة في معرض الكتاب',
      totalVolunteers: 30,
      joinedVolunteers: 15,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // حقل البحث
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                fillColor: AppColors.white,
                hintText: 'أنا أبحث عن...',
                suffixIcon: const Icon(Icons.search),
                suffixIconColor: AppColors.grey2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // قائمة الفعاليات
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, -4),
                        ),
                      ],
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: ListView.builder(
                        itemCount: events.length,
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          return OpportunityCard(event: events[index]);
                        },
                      ),
                    ),
                  ),

                  // زر الفلترة العائم
                  Positioned(
                    bottom: 474,

                    right: 46,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange.shade300,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.filter_alt, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
