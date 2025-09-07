import 'package:ammerha_volunteer/config/routes/app_routes.dart';
import 'package:ammerha_volunteer/config/routes/route_generator.dart';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/helper/api.dart';
import 'package:ammerha_volunteer/core/provider/auth/auth_provider.dart';
import 'package:ammerha_volunteer/core/provider/auth/registeration_provider.dart';
import 'package:ammerha_volunteer/core/provider/events_provider.dart';
import 'package:ammerha_volunteer/core/provider/honor_board_provider.dart';
import 'package:ammerha_volunteer/core/provider/news_provider.dart';
import 'package:ammerha_volunteer/core/provider/volunteer_provider.dart';
import 'package:ammerha_volunteer/core/services/events_service.dart';
import 'package:ammerha_volunteer/core/services/news_service.dart';
import 'package:ammerha_volunteer/core/services/volunteer_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final api = Api();
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'auth_token');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(
          create: (context) => EventsProvider(EventsService(api)),
        ),
        ChangeNotifierProvider(
          create: (context) => VolunteerProvider(VolunteerService(api, token)),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsProvider(NewsService(api)),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              HonorBoardProvider(service: VolunteerService(api, token)),
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
