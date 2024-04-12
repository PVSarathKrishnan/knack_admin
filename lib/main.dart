import 'package:flutter/material.dart';
import 'package:knack_admin/presentation/controller_screen.dart';
import 'package:knack_admin/presentation/home_screen.dart';
import 'package:knack_admin/presentation/login_screen.dart';
import 'package:knack_admin/presentation/splash_screen.dart';
import 'package:knack_admin/presentation/user_management.dart';


const SAVE_KEY_NAME ="UserLoggedIn";
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: SplashScreen(screenWidth: screenWidth));
      home: UserDetailsScreen(),
      // home: SplashScreen(
      //   screenWidth: screenWidth,
      // ),
    );
  }
}
