import 'package:ammerha_volunteer/core/models/volunteer.dart';
import 'package:ammerha_volunteer/core/models/volunteer_profile.dart';
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

  final String name = "ميسان";
  final String image = "assets/images/level1(2).jpg";

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

  final VolunteerProfile volunteerProfile = VolunteerProfile(
    name: 'حذيفة ابراهيم جوهر',
    id: '12',
    profileImageUrl: 'assets/images/profile.png',
    opportunitiesCount: 0,
    hoursCount: 0,
    rankTier: RankTier.gold,
    rankName: 'متطوع مبتدئ',
    rankProgress: 0.3, // Represents 30%
    skills: ['التصوير', 'التصميم', 'التدريب', 'جمع التبرعات', 'إدارة المشاريع'],
    completedOpportunities: [
      CompletedOpportunity(
        title: 'تنظيم فعالية اليوم الوطني',
        date: '23-09-2024',
      ),
      CompletedOpportunity(title: 'حملة تشجير ', date: '15-10-2024'),
    ],
    socialLinks: {
      'facebook': 'https://facebook.com/yourprofile',
      'linkedin': 'https://linkedin.com/in/yourprofile',
      'instagram': 'https://instagram.com/yourprofile',
    },
  );

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

      drawer: CustomDrawer(volunteerProfile: volunteerProfile),

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
