import 'package:flutter/material.dart';
import 'package:refrigerator_frontend/add_ingredients.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExpansionTile Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AddIngredientsScreen(), // 사용: ExpansionTileDemo 위젯을 사용
      );
  }
}
