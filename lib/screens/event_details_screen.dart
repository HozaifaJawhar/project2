// lib/screens/event_details_screen.dart
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:ammerha_volunteer/core/models/event_class.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
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
            event.title,
            style: GoogleFonts.almarai(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
        body: ListView(
          children: [
            Image(
              image: AssetImage(event.imageUrl),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                event.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(10.0), child: Text('data')),
          ],
        ),
      ),
    );
  }
}
