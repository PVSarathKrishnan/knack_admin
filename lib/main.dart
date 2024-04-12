import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:knack_admin/firebase_options.dart';
import 'package:knack_admin/presentation/splash_screen.dart';
import 'package:knack_admin/presentation/user_management.dart';


const SAVE_KEY_NAME ="UserLoggedIn";
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    home: SplashScreen(),
    );
  }
}
