import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_sekuritas/article_details/view.dart';
import 'package:yb_sekuritas/forget_password/view.dart';
import 'package:yb_sekuritas/login/view.dart';
import 'package:yb_sekuritas/otp_pin/view.dart';
import 'package:yb_sekuritas/reset_password/view.dart';

import 'home/view.dart';
import 'landing/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    WidgetsFlutterBinding.ensureInitialized();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
        ),
        dividerColor: Colors.transparent,
        cardColor: Colors.white,
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/landing', page: () => LandingPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/forget_password', page: () => ForgetPasswordPage()),
        GetPage(name: '/otp_pin', page: () => OtpPinPage()),
        GetPage(name: '/reset_password', page: () => ResetPasswordPage()),
        GetPage(name: '/article_details', page: () => ArticleDetailsPage()),
      ],
      initialRoute: '/landing',
    );
  }
}
