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
  ];
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('data'));
    // Directionality(
    //   textDirection: TextDirection.rtl,
    //   child: Stack(
    //     children: [
    //       Column(
    //         children: [
    //           Expanded(
    //             child: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                   fillColor: AppColors.white,
    //                   hintText: 'انا ابحث عن...',
    //                   suffixIcon: const Icon(Icons.search),
    //                   suffixIconColor: AppColors.grey2,
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(12),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 30),

    //           Expanded(
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color: Colors.grey.shade300,
    //                     spreadRadius: 2,
    //                     blurRadius: 6,
    //                     offset: Offset(0, -4),
    //                   ),
    //                 ],
    //                 color: AppColors.white,
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(40),
    //                   topRight: Radius.circular(40),
    //                 ),
    //               ),

    //               width: double.infinity,
    //               height: 100,
    //               child: ListView.builder(
    //                 itemCount: events.length,
    //                 padding: const EdgeInsets.all(16),
    //                 itemBuilder: (context, index) {
    //                   return OpportunityCard(event: events[index]);
    //                 },
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(right: 46, top: 88),
    //         child: Container(
    //           decoration: BoxDecoration(
    //             boxShadow: [],
    //             color: Colors.orange.shade300,
    //             borderRadius: BorderRadius.circular(10),
    //           ),
    //           padding: const EdgeInsets.all(8),
    //           child: const Icon(Icons.filter_alt, color: Colors.white),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
