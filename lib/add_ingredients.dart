import 'package:flutter/material.dart';
import 'package:refrigerator_frontend/search_ingredients.dart';
import 'package:refrigerator_frontend/home.dart';
import 'package:refrigerator_frontend/widgets/ingredients_title.dart';


final List<String> imagePaths = [
  'assets/images/food.png',
  'assets/images/food.png',
  'assets/images/food.png',
  'assets/images/food.png',
  'assets/images/food.png',
];




class AddIngredientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('검색'),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchIngredientsScreen()));
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            IngredientsTile(title: '가공 / 유제품', imagePaths: imagePaths),
            IngredientsTile(title: '고기', imagePaths: imagePaths),
            IngredientsTile(title: '곡물', imagePaths: imagePaths),
            IngredientsTile(title: '과일', imagePaths: imagePaths),
            IngredientsTile(title: '면', imagePaths: imagePaths),
            IngredientsTile(title: '빵 / 떡', imagePaths: imagePaths),
            IngredientsTile(title: '음료 / 주류', imagePaths: imagePaths),
            IngredientsTile(title: '채소', imagePaths: imagePaths),
            IngredientsTile(title: '콩 / 견과류', imagePaths: imagePaths),
            IngredientsTile(title: '해산물', imagePaths: imagePaths),
            IngredientsTile(title: '조미료 / 양념', imagePaths: imagePaths),
          ],
        )
    );
  }
}
