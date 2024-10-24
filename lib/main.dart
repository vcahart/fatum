import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fatum/routes.dart';
import 'package:fatum/screens/onboarding_screen.dart';
import 'package:fatum/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isviewed;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding',
      theme: ThemeData(scaffoldBackgroundColor: HexColor("#FBFCFF")),
      home: isviewed != 0 ? const OnboardingScreen() : const WelcomeScreen(),
      routes: getApplicactionRoutes(),
    );
  }
}