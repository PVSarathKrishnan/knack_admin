import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knack_admin/Domain/infrastructure/user_repository.dart';
import 'package:knack_admin/application/bloc/bloc/fetch_user_bloc.dart';
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
        BlocProvider(create: (context) => FetchUserBloc(UserRepo()),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
      home: SplashScreen(),
      ),
    );
  }
}
