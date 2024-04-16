
import 'package:flutter/material.dart';
import 'package:knack_admin/main.dart';
import 'package:knack_admin/presentation/controller_screen.dart';
import 'package:knack_admin/presentation/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    proceedToDashBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'lib/assets/logo.png',
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  Future<void> proceedToDashBoard() async {
    final _sharedprefs = await SharedPreferences.getInstance();
    final _userLoggedIn = _sharedprefs.getBool(SAVE_KEY_NAME);
    if (_userLoggedIn == null || _userLoggedIn == false) {
      await Future.delayed(Duration(seconds: 3));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    } else {
      await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => ControllerScreen()));
    }
  }
}
