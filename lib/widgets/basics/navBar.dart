import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      backgroundColor: Color(0xFF002366), // نفس لون الخلفية الأزرق الداكن
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: 'الفرص'),
        BottomNavigationBarItem(
          icon: Icon(Icons.emoji_events_outlined),
          label: 'لوحة الشرف',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article_outlined),
          label: 'الأخبار',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'الشخصية',
        ),
      ],
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    );
  }
}
