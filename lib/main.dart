import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:student_helper/firebase_options.dart';
import 'package:student_helper/helpers/theme_colors.dart';

import 'package:student_helper/pages/home_page.dart';
import 'package:student_helper/pages/passwordReset_page.dart';
import 'package:student_helper/pages/start_page.dart';
import 'package:student_helper/pages/login_page.dart';
import 'package:student_helper/pages/signup_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StudentHelper',
      routes: {
        StartPage.routename:(context)=>StartPage(),
        LoginPage.routename:(context)=>LoginPage(),
        HomePage.routename:(context)=>HomePage(),
        ResetPage.routename:(context)=>ResetPage()
      },
      theme: ThemeData(
        primaryColor: ThemeColors.primaryColor,
        scaffoldBackgroundColor: ThemeColors.scaffoldBgColor,
      ),
      initialRoute: StartPage.routename,
    );
  }
}
