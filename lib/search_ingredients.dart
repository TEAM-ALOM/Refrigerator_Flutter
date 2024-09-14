import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

class SearchIngredientsScreen extends StatefulWidget {
  const SearchIngredientsScreen({super.key});

  @override
  _SearchIngredientsScreenState createState() =>
      _SearchIngredientsScreenState();
}

class _SearchIngredientsScreenState extends State<SearchIngredientsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Search Ingredient',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
