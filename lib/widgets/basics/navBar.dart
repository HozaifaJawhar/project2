import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // خلفية الـ BottomBar
        Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Color(0xFF00205B), // الأزرق الداكن
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(icon: Icons.person, label: 'الشخصية', index: 4),
              _buildNavItem(icon: Icons.article, label: 'الأخبار', index: 3),
              const SizedBox(width: 50), // فراغ للزر العائم
              _buildNavItem(
                icon: Icons.military_tech,
                label: 'لوحة الشرف',
                index: 2,
              ),
              _buildNavItem(icon: Icons.work, label: 'الفرص', index: 1),
            ],
          ),
        ),
        // زر الرئيسية البارز
        Positioned(
          bottom: 30,
          child: GestureDetector(
            onTap: () => onTap(0),
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF00205B), width: 4),
              ),
              child: Icon(Icons.home, size: 30, color: Color(0xFF00205B)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
