import 'package:flutter/material.dart';
import 'package:refrigerator_frontend/screens/home_screen.dart';
import 'package:refrigerator_frontend/screens/search_screen.dart';
import 'package:refrigerator_frontend/widgets/ingredients_title.dart';

final List<String> imagePaths = [
  'assets/images/food/food.png',
  'assets/images/food/food.png',
  'assets/images/food/food.png',
  'assets/images/food/food.png',
  'assets/images/food/food.png',
];

class AddIngredientsScreen extends StatelessWidget {
  const AddIngredientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('검색'),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
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
        ));
  }
}
