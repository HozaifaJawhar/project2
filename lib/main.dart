import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/screens/events.dart';
import 'package:ammerha_volunteer/screens/honor_board.dart';
import 'package:ammerha_volunteer/screens/login.dart';
import 'package:ammerha_volunteer/screens/mian_navigation_screen.dart';
import 'package:ammerha_volunteer/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: MainNavigationScreen(),
    );
  }
}
