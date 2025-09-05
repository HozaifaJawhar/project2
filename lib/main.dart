import 'package:ammerha_volunteer/config/routes/app_routes.dart';
import 'package:ammerha_volunteer/config/routes/route_generator.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/provider/auth/auth_provider.dart';
import 'package:ammerha_volunteer/core/provider/auth/registeration_provider.dart';
import 'package:ammerha_volunteer/core/provider/events_provider.dart';
import 'package:ammerha_volunteer/core/services/events_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final api = Api(); // الكلاس تبعك يلي بيعمل requests
  final eventsService = EventsService(api);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(
          create: (context) => EventsProvider(eventsService),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      //home: MainNavigationScreen(),
      initialRoute: AppRoutes.splashRoute,
      // Handles all named route generation via the RouteGenerator class.
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
