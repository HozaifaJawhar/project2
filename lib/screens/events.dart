import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/provider/events_provider.dart';
import 'package:ammerha_volunteer/core/services/events_service.dart';
import 'package:ammerha_volunteer/widgets/events/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> _ensureFetch(BuildContext context) async {
    // CHANGE: We fetch the token and then launch the fetch from within the page after building
    final token = await _storage.read(key: 'auth_token');

    final p = context.read<EventsProvider>();
    if (!p.isLoading && p.events.isEmpty) {
      await p.fetchEvents(token: token, force: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    void showFilterSheet(BuildContext context) {
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

    return ChangeNotifierProvider<EventsProvider>(
      create: (_) => EventsProvider(EventsService(Api())),
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _ensureFetch(context);
          });
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Consumer<EventsProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.error != null) {
                    return Center(child: Text('خطأ: ${provider.error}'));
                  }
                  if (provider.events.isEmpty) {
                    return const Center(child: Text("لا توجد فعاليات بعد"));
                  }
                  return Column(
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: RefreshIndicator(
                                      onRefresh: () async {
                                        final token = await _storage.read(
                                          key: 'auth_token',
                                        );
                                        if (token != null) {
                                          await provider.refresh(
                                            token: token,
                                          ); // استدعاء refresh للبروفايدر
                                        }
                                      },
                                      child: ListView.builder(
                                        itemCount: provider.events.length,
                                        itemBuilder: (context, index) {
                                          final eventt = provider.events[index];
                                          return OpportunityCard(event: eventt);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // زر الفلترة العائم
                              Positioned(
                                top: MediaQuery.of(context).size.height * -0.03,

                                right:
                                    MediaQuery.of(context).size.height * 0.08,
                                child: GestureDetector(
                                  onTap: () {
                                    showFilterSheet(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade300,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
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
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
