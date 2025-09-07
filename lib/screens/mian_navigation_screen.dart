
import 'package:flutter/material.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/screens/events.dart';
import 'package:ammerha_volunteer/screens/honor_board.dart';
import 'package:ammerha_volunteer/screens/news.dart';
import 'package:ammerha_volunteer/screens/profile_screen.dart';
import 'package:ammerha_volunteer/widgets/basics/drawar.dart';
import 'package:ammerha_volunteer/widgets/basics/navBar.dart';
import 'package:google_fonts/google_fonts.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    EventsScreen(),
    HonorBoardScreen(),
    NewsScreen(),
    VolunteerProfileScreen(),
  ];

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'الفرص';
      case 1:
        return 'لوحة الشرف';
      case 2:
        return 'الأخبار';
      case 3:
        return 'الملف الشخصي';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          _getTitle(currentIndex),
          style: GoogleFonts.almarai(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (currentIndex == 0)
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
        ],
      ),

      drawer: CustomDrawer(),

      body: IndexedStack(index: currentIndex, children: _screens),

      bottomNavigationBar: CustomBottomBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
