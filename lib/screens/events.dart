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
      time: '1:00',
      category: 'صحي',
      title: 'فعالية التبرع بالدم',
      description:
          'تهدف هذه الفعالية الى تقوية التكاتف الاجتماعي وروح المبادرة والتخفيف عن المرضى وذويهم متاعب البحث عن زمر الدم المطلوبة',
      place: 'مشفى المواساة',
      totalVolunteers: 50,
      joinedVolunteers: 20,
      hours: 2,
    ),
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '٥ أغسطس ٢٠٢٥',
      time: '1:00',
      category: 'ثقافي',
      title: 'مساعدة في معرض الكتاب',
      description:
          'تهدف هذه الفعالية الى تقوية التكاتف الاجتماعي وروح المبادرة والتخفيف عن المرضى وذويهم متاعب البحث عن زمر الدم المطلوبة',
      place: 'مشفى المواساة',
      totalVolunteers: 30,
      joinedVolunteers: 15,
      hours: 2,
    ),
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '٥ أغسطس ٢٠٢٥',
      time: '1:00',
      category: 'ثقافي',
      title: 'مساعدة في معرض الكتاب',
      description:
          'تهدف هذه الفعالية الى تقوية التكاتف الاجتماعي وروح المبادرة والتخفيف عن المرضى وذويهم متاعب البحث عن زمر الدم المطلوبة',
      place: 'مشفى المواساة',
      totalVolunteers: 30,
      joinedVolunteers: 15,
      hours: 2,
    ),
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '٥ أغسطس ٢٠٢٥',
      time: '1:00',
      category: 'ثقافي',
      title: 'مساعدة في معرض الكتاب',
      description:
          'تهدف هذه الفعالية الى تقوية التكاتف الاجتماعي وروح المبادرة والتخفيف عن المرضى وذويهم متاعب البحث عن زمر الدم المطلوبة',
      place: 'مشفى المواساة',
      totalVolunteers: 30,
      joinedVolunteers: 15,
      hours: 2,
    ),
    Event(
      imageUrl: 'assets/images/event_image.jpg',
      date: '٥ أغسطس ٢٠٢٥',
      time: '1:00',
      category: 'ثقافي',
      title: 'مساعدة في معرض الكتاب',
      description:
          'تهدف هذه الفعالية الى تقوية التكاتف الاجتماعي وروح المبادرة والتخفيف عن المرضى وذويهم متاعب البحث عن زمر الدم المطلوبة',
      place: 'مشفى المواساة',
      totalVolunteers: 30,
      joinedVolunteers: 15,
      hours: 2,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    void _showFilterSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          String? selectedYear;
          String? selectedCategory;

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: [
                    const Text(
                      'اختر سنة الفعالية',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedYear,
                      isExpanded: true,
                      hint: const Text('السنة'),
                      items: ['2023', '2024', '2025']
                          .map(
                            (year) => DropdownMenuItem(
                              value: year,
                              child: Text(year),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedYear = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'اختر مجال التطوع',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      hint: const Text('المجال'),
                      items: ['صحي', 'ثقافي', 'بيئي', 'اجتماعي']
                          .map(
                            (field) => DropdownMenuItem(
                              value: field,
                              child: Text(field),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedCategory = value);
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade400,
                      ),
                      onPressed: () {
                        // نضع هنا الفلترة حسب selectedYear و selectedCategory
                        Navigator.pop(context);
                        print('فلترة على $selectedYear - $selectedCategory');
                      },
                      child: const Text('تطبيق الفلاتر'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

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
                    top: MediaQuery.of(context).size.height * -0.03,

                    right: MediaQuery.of(context).size.height * 0.08,
                    child: GestureDetector(
                      onTap: () {
                        _showFilterSheet(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange.shade300,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.filter_alt,
                          color: Colors.white,
                        ),
                      ),
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
