import 'package:flutter/material.dart';

class SearchIngredientsScreen extends StatefulWidget {
  @override
  _SearchIngredientsScreenState createState() => _SearchIngredientsScreenState();
}

class _SearchIngredientsScreenState extends State<SearchIngredientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Ingredient'),
      ),
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
