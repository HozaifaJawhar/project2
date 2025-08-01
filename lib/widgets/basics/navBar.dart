import 'package:flutter/material.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';

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
    // عدد العناصر
    const itemCount = 4;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // خلفية البار
        Container(
          height: 75,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(itemCount, (index) {
              // لا ترسم الزر داخل Row إذا كان هو المحدد
              if (index == currentIndex) {
                return const SizedBox(width: 60); // احجز مكانه فقط
              }
              return _buildNavItem(index: index);
            }),
          ),
        ),

        // الزر العائم للمحدد فقط
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuad,
          bottom: 20,
          left: _getPosition(context, currentIndex, itemCount),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: GestureDetector(
              key: ValueKey<int>(currentIndex), // لضمان تبديل الأزرار
              onTap: () => onTap(currentIndex),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          _getIcon(currentIndex),
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _getLabel(currentIndex),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // مكان الزر حسب الفهرس والعرض
  double _getPosition(BuildContext context, int index, int itemCount) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = (screenWidth - 20) / itemCount;
    return 10 + spacing * index + (spacing / 2) - 30;
  }

  Widget _buildNavItem({required int index}) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_getIcon(index), color: Colors.white),
          const SizedBox(height: 4),
          Text(
            _getLabel(index),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.work;
      case 1:
        return Icons.military_tech;
      case 2:
        return Icons.article;
      case 3:
        return Icons.person;
      default:
        return Icons.circle;
    }
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'الفرص';
      case 1:
        return 'لوحة الشرف';
      case 2:
        return 'الأخبار';
      case 3:
        return 'الشخصية';
      default:
        return '';
    }
  }
}
