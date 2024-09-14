import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:refrigerator_frontend/add_ingredients.dart';
import 'package:refrigerator_frontend/book_mark.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/home.dart';

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
      home: const HomeScreen(), // 사용: ExpansionTileDemo 위젯을 사용
    );
  }
}
