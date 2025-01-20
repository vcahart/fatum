
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import 'features/authentication/controllers/signup_controller.dart';
import 'features/authentication/screens/onboarding/onboarding_screen.dart';
import 'features/core/controllers/bmi_controller.dart';
import 'features/core/controllers/profile_controller.dart';
import 'firebase_options.dart';
import 'repository/authentication_repository/authentication_repository.dart';
import 'repository/user_repository/user_repository.dart';
import 'utils/theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: TAppTheme.lightTheme,
      themeMode: ThemeMode.light,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthenticationRepository());
        Get.put(UserRepository());
        Get.put(SignUpController());
        Get.put(ProfileController());
        Get.put(BmiController());
      }),
      home: OnboardingScreen(),
    );
  }
}
