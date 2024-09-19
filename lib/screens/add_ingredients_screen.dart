import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/screens/main_tab_bar.dart';
import 'package:refrigerator_frontend/screens/search_screen.dart';
import 'package:refrigerator_frontend/widgets/ingredients_title.dart';
import 'package:http/http.dart' as http;

import '../models/user_auth.dart';

class AddIngredientsScreen extends StatefulWidget {
  const AddIngredientsScreen({super.key});

  @override
  State<AddIngredientsScreen> createState() => _AddIngredientsScreenState();
}

class _AddIngredientsScreenState extends State<AddIngredientsScreen> {
  static Map<String, String> mainIngredients = {};
  static Map<String, String> subIngredients = {};
  static Map<String, String> seasonings = {};

  Future<void> getIngredients(String category) async {
    final Uri url = Uri.parse(
        'http://43.201.84.66:8080/api/ingredients/category/$category');
    String? myToken = await getAccessToken();
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $myToken',
        },
      );
      // print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

// 'id'와 'name'을 Map으로 저장
        Map<String, String> ingredients = {
          for (var item in data) item['name']: category,
        };

// 출력
//       print(ingredients);

        if (category == "주재료") {
          mainIngredients = ingredients;
        } else if (category == "부재료")
          subIngredients = ingredients;
        else
          seasonings = ingredients;
        // 결과 출력
      } else {
        print(
            'Failed to load data: ${response.statusCode}'); // 상태 코드가 200이 아닌 경우
      }
    } catch (e) {
      print('Error: ${e.toString()}'); // 예외 발생 시
    }
  }

  @override
  void initState() {
    _initializeIngredients();

    super.initState();
  }

  Future<void> _initializeIngredients() async {
    await getIngredients("주재료");
    await getIngredients("부재료");
    await getIngredients("양념");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              '검색',
              style: TextStyle(fontFamily: "CookieRun"),
            ),
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
            IngredientsTile(title: '주재료', ingredientsMap: mainIngredients),
            IngredientsTile(title: '부재료', ingredientsMap: subIngredients),
            IngredientsTile(title: '양념', ingredientsMap: seasonings),
          ],
        ));
  }
}
