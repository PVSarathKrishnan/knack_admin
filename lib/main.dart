import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knack_admin/Domain/infrastructure/user_repository.dart';
import 'package:knack_admin/application/bloc/course%20bloc/bloc/course_bloc.dart';
import 'package:knack_admin/application/bloc/cover%20image%20bloc/bloc/cover_image_bloc.dart';
import 'package:knack_admin/application/bloc/user%20bloc/fetch_user_bloc.dart';
import 'package:knack_admin/firebase_options.dart';
import 'package:knack_admin/presentation/add_course_screen.dart';
import 'package:knack_admin/presentation/splash_screen.dart';


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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FetchUserBloc(UserRepo()),),

        BlocProvider(create: (context) => CourseBloc(),),

        BlocProvider(create: (context) => CoverImageBloc(),),

      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.green,
        colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.green, onPrimary: Color.fromARGB(255, 0, 0, 0), secondary: Colors.black, onSecondary: Colors.black26, error: Colors.red, onError: const Color.fromARGB(255, 255, 17, 0), background: const Color.fromARGB(255, 214, 214, 214), onBackground:Colors.grey, surface: Colors.green, onSurface: Colors.black),
        useMaterial3: false),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
      home: AddCourseScreen(),
      ),
    );
  }
}
