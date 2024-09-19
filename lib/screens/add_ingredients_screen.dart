import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/home_screen.dart';
import 'package:refrigerator_frontend/screens/search_screen.dart';
import 'package:refrigerator_frontend/widgets/ingredients_title.dart';
import 'package:http/http.dart' as http;

import '../models/user_auth.dart';

final List<String> imagePaths = [
  'assets/images/food/foodsdjfljdlfjslkjflkdjl.png',
  'assets/images/food/food.png',
  'assets/images/food/food.png',
  'assets/images/food/food.png',
  'assets/images/food/food.png',
];

List<String> mainIngredients=[];
List<String> subIngredients=[];
List<String> seasonings=[];


Future<void> getIngredients(String category) async {
  final Uri url = Uri.parse('http://43.201.84.66:8080/api/ingredients/category/${category}}');
  String? myToken = await getAccessToken();
  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $myToken',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      print(data[0]['id']);   // 0
      print(data[0]['name']); // "string"
      print(data);
      print(data.length);
      // '주재료'만 필터링하여 name 추출
      List<String> Ingredients = data
          .map((item) => item['name'] as String)
          .toList();

      // 가나다순으로 정렬
      mainIngredients.sort();

      // 결과 출력
    } else {
      print('Failed to load data: ${response.statusCode}'); // 상태 코드가 200이 아닌 경우
    }
  } catch (e) {
    print('Error: ${e.toString()}'); // 예외 발생 시
  }
}

class AddIngredientsScreen extends StatelessWidget {
  const AddIngredientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getIngredients("주재료");
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
          backgroundColor: background,
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: HexColor('#E3E3E3'),
          // shape: Border(bottom: BorderSide(color: Colors.black)),
        ),
        body: ListView(
          children: <Widget>[
            IngredientsTile(title: '주재료', imagePaths: mainIngredients),
            IngredientsTile(title: '부재료', imagePaths: subIngredients),
            IngredientsTile(title: '양념', imagePaths: seasonings),
          ],
        ));
  }
}
