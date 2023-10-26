import 'package:flutter/material.dart';
import 'package:blind/modules/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:blind/modules/login/login.dart';
import 'package:blind/modules/map/map.dart';
import 'package:blind/modules/signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey:'AIzaSyDJoL-tU_HGXo9bwChHFp0Cf-nYpDIiGHU',
          appId:'1:482633403296:android:2b7af55591b38eb2abb2c5',
          messagingSenderId:'482633403296',
          projectId:'smart-shue'
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => const HomeScreen(),
        'registration_screen': (context) => const SignUpScreen(),
        'login_screen': (context) => const LoginScreen(),
        'home_screen': (context) => const Map()
      },
    );
  }
}
