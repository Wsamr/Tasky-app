import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_shared_pref.dart';
import 'package:tasky_app/screens/auth/login_screen.dart';
import 'package:tasky_app/screens/auth/register_screen.dart';
import 'package:tasky_app/screens/detailsScreen/details_screen.dart';
import 'package:tasky_app/screens/home/home_screen.dart';
import 'package:tasky_app/screens/home/widgets/home_screen_filled_widget.dart';
import 'package:tasky_app/screens/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasky_app/screens/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPref.initSharedPref();
  String routeName = SplashScreen.routeName;
  // AppSharedPref.removeData("Id");
  AppSharedPref.getData("Id").then((value) {
    if (value != null) routeName = HomeScreen.routeName;
    
  });

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting().then(
    (_) => runApp(TaskyApp(routeName: routeName)),
  );
  print(FirebaseAuth.instance.currentUser?.uid);
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key, required this.routeName});
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        HomeScreenFilledWiidget.routeName:
            (context) => HomeScreenFilledWiidget(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        DetailsScreen.routeName: (context) => DetailsScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
    );
  }
}
