import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colos.dart';

class SearchIngredientsScreen extends StatefulWidget {
  @override
  _SearchIngredientsScreenState createState() => _SearchIngredientsScreenState();
}

class _SearchIngredientsScreenState extends State<SearchIngredientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
