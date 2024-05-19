import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knack_admin/main.dart';
import 'package:knack_admin/presentation/controller_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Admin Login",
                style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 0, 255, 106),
                    fontSize: screenWidth / 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenHeight / 10,
              ),
              CustomTextFieldWidget(userNameController, "User Name"),
              SizedBox(
                height: screenHeight / 30,
              ),
              CustomTextFieldWidget(passwordController, "Password"),
              SizedBox(
                height: screenHeight / 25,
              ),
              InkWell(
                onTap: _login,
                child: Container(
                  width: screenWidth / 6,
                  height: screenHeight / 15,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: screenWidth / 50,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (userNameController.text == "admin@knack" &&
        passwordController.text == "admin@123") {
      // shared pref
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(SAVE_KEY_NAME, true);
      //snackbar
      CustomSnackbar("Perfect, Welcome ", context);
      Future.delayed(
        Duration(seconds: 1),
        () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ControllerScreen(),
              ));
        },
      );
    } else {
      CustomSnackbar("Oops, Credentials don't match, try again", context);
    }
  }

  CustomSnackbar(String content, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 4.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      duration: Duration(seconds: 3),
    ));
  }

  CustomTextFieldWidget(TextEditingController controller, String label) {
    return TextFormField(
      style: GoogleFonts.poppins(
        color: Colors.green,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      controller: controller,
      decoration: InputDecoration(
          fillColor: Color.fromARGB(255, 19, 19, 19),
          filled: true,
          label: Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white))),
    );
  }
}
