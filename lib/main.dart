import 'package:ammerha_volunteer/config/routes/app_routes.dart';
import 'package:ammerha_volunteer/config/routes/route_generator.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';

import 'package:ammerha_volunteer/screens/mian_navigation_screen.dart';

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
      initialRoute: AppRoutes.loginRoute,
      // Handles all named route generation via the RouteGenerator class.
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
