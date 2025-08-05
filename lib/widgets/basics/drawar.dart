import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Drawar1 extends StatelessWidget {
  final String userName;
  final String? userImage;
  const Drawar1({super.key, required this.userName, this.userImage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          // gradient: LinearGradient(
          //   colors: [Colors.white, AppColors.primary],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: ListView(
          padding: EdgeInsets.all(0),

          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.white,
                    backgroundImage: AssetImage(
                      "$userImage",
                    ), // أو NetworkImage
                  ),
                  SizedBox(height: 10),
                  Text(
                    'مرحبًا، $userName',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('الإعدادات', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.light_mode, color: Colors.white),
              title: Text('المظهر', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.style, color: Colors.white),
              title: Text(
                'طلب شهادة التطوع',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.white),
              title: Text('حذف حسابي', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                'تسجيل الخروج',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
