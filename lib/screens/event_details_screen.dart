// lib/screens/event_details_screen.dart

import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/models/event.dart';
import 'package:ammerha_volunteer/core/provider/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final Eventt event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isRegistered = false;
  _showConfirmationDialog(BuildContext context) {
    if (isRegistered) return;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('تأكيد'),
          content: const Text('هل أنت متأكد أنك تريد المشاركة؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('لا'),
            ),
            TextButton(
              onPressed: () async {
                final provider = context.read<EventsProvider>();
                Navigator.of(dialogContext).pop();

                const storage = FlutterSecureStorage();
                final token = await storage.read(key: 'auth_token') ?? "";

                final result = await provider.registerToEvent(
                  widget.event,
                  token,
                );
                print('mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
                print(result);
                if (!mounted) return;

                switch (result) {
                  case "success":
                    setState(() => isRegistered = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: AppColors.primary,
                        content: Text("تم التسجيل بنجاح!"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    break;

                  case "already_registered":
                    setState(() => isRegistered = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text("لقد سجلت مسبقاً في هذه الفعالية."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    break;

                  default:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text("فشل التسجيل، حاول مرة أخرى."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                }
              },
              child: const Text('نعم'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;

    // التاريخ
    final String formattedDate = event.date != null
        ? intl.DateFormat('yyyy-MM-dd').format(event.date!)
        : 'غير محدد';

    final String formattedTime = event.date != null
        ? intl.DateFormat('HH:mm').format(event.date!)
        : 'غير محدد';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {},
            ),
          ],
          backgroundColor: AppColors.primary,
          centerTitle: true,
          title: Text(
            widget.event.name,
            style: GoogleFonts.almarai(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
        body: ListView(
          children: [
            _EventCoverImage(url: event.coverImage?.file),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.event.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.event.description,
                style: TextStyle(color: AppColors.greyText, fontSize: 13),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 15,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'زمان الفعالية:',
                style: GoogleFonts.almarai(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                '${formattedDate}          الساعة:${formattedTime}',
                style: TextStyle(color: AppColors.greyText, fontSize: 13),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 15,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                'عدد المتطوعين',
                style: GoogleFonts.almarai(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
              child: Row(
                children: [
                  Text(
                    'المطلوب:  ',
                    style: GoogleFonts.almarai(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '${widget.event.volunteersCount}',
                    style: GoogleFonts.almarai(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'المتبقي:  ',
                    style: GoogleFonts.almarai(
                      fontSize: 12,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '${widget.event.acceptedCount}',
                    style: GoogleFonts.almarai(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 15,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'مكان الفعالية:',
                style: GoogleFonts.almarai(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                event.location ?? 'غير محدد',
                style: TextStyle(color: AppColors.greyText, fontSize: 13),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 15,
              indent: 15,
              endIndent: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'عدد الساعات التطوعية:',
                style: GoogleFonts.almarai(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                '${formattedTime}',
                style: TextStyle(color: AppColors.greyText, fontSize: 13),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 15,
              indent: 15,
              endIndent: 15,
            ),

            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Center(
            //     child: Text(
            //       'المشرف على الفعالية:}',
            //       style: GoogleFonts.almarai(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 15,
            //         color: AppColors.primary,
            //       ),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () async {
                  if (isRegistered) {
                    // إذا مسجل مسبقاً، فقط عرض رسالة
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.orange,
                        content: Text("لقد سجلت مسبقاً في هذه الفعالية."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // إذا ما مسجل، نفتح مربع التأكيد
                  _showConfirmationDialog(context);
                },
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text(
                      isRegistered ? 'تم التسجيل' : 'تسجيل',
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Image(
        image: AssetImage('assets/images/event_image.jpg'),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      // بإمكانك إضافة loadingBuilder إن حبيت
    );
  }
}
