import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knack_admin/Domain/infrastructure/course_repository.dart';
import 'package:knack_admin/Domain/infrastructure/user_repository.dart';
import 'package:knack_admin/application/bloc/course%20bloc/bloc/course_bloc.dart';
import 'package:knack_admin/application/bloc/cover%20image%20bloc/bloc/cover_image_bloc.dart';
import 'package:knack_admin/application/bloc/document%20bloc/bloc/document_bloc.dart';
import 'package:knack_admin/application/bloc/fetch%20course%20bloc/bloc/fetch_course_bloc.dart';
import 'package:knack_admin/application/bloc/user%20bloc/fetch_user_bloc.dart';
import 'package:knack_admin/firebase_options.dart';
import 'package:knack_admin/presentation/course/add_course_screen.dart';
import 'package:knack_admin/presentation/login/splash_screen.dart';

const SAVE_KEY_NAME = "UserLoggedIn";

void main() async {
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
        BlocProvider(
          create: (context) => FetchUserBloc(UserRepo()),
        ),
        BlocProvider(
          create: (context) => CourseBloc(),
        ),
        BlocProvider(
          create: (context) => CoverImageBloc(),
        ),
        BlocProvider(
          create: (context) => DocumentBloc(),
        ),
        BlocProvider(
          create: (context) => FetchCourseBloc(CourseRepo()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green,
          colorScheme: ColorScheme(
            primary: Colors.green,
            onPrimary: Colors.black,
            secondary: const Color.fromARGB(255, 255, 255, 255),
            onSecondary: const Color.fromARGB(255, 0, 0, 0),
            surface: const Color.fromARGB(255, 255, 255, 255),
            onSurface: const Color.fromARGB(255, 0, 0, 0),
            background: const Color.fromARGB(255, 0, 0, 0),
            onBackground: Colors.black,
            error: Colors.red,
            onError: Colors.white,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.green,
            textTheme: ButtonTextTheme.primary,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green,
          ),
          iconTheme: IconThemeData(color: Colors.green),
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashScreen(),
      ),
    );
  }
}
