import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:refrigerator_frontend/models/user_auth.dart';
import 'package:refrigerator_frontend/screens/add_ingredients_screen.dart';
import 'package:refrigerator_frontend/screens/bookmark_screen.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/main_tab_bar.dart';
import 'package:refrigerator_frontend/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '냉장고의 꿈',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: background, // 전체 배경 색 설정
        textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme), // 전체 폰트 설정(Inter)
      ),
      home: const LoginScreen(), // 사용: ExpansionTileDemo 위젯을 사용
    );
  }
}
