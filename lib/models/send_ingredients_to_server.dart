import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:refrigerator_frontend/cards.dart';
import 'package:refrigerator_frontend/colors.dart';
import 'package:refrigerator_frontend/models/get_ingredient_id.dart';
import 'package:refrigerator_frontend/screens/home_screen.dart';
import 'package:refrigerator_frontend/screens/add_ingredients_screen.dart';
import 'package:http/http.dart' as http;
import '../models/send_ingredients_to_server.dart';
import '../models/user_auth.dart';

Future<void> sendIngredientToServer({
  required int ingredientId,
  required String category,
  required int quantity,
  required DateTime purchaseDate,
  required DateTime expirationDate,
  required bool isFrozen,
  required bool isRefrigerated,
}) async {
  final Uri url = Uri.parse('http://43.201.84.66:8080/api/ingredients/send');
  String? myToken = await getAccessToken(); // 토큰을 비동기적으로 가져옵니다
  String formattedPurchaseDate = DateFormat('yyyy-MM-dd').format(
      purchaseDate);
  String formattedExpirationDate = DateFormat('yyyy-MM-dd').format(
      expirationDate);
  // JSON 형식으로 요청 본문을 작성합니다
  final List<Map<String, dynamic>> requestBody = [{
    'ingredientId': ingredientId,
    'category': category,
    'quantity': quantity,
    'purchaseDate': formattedPurchaseDate,
    'expiredDate': formattedExpirationDate,
    'isFrozen': isFrozen,
    'isRefrigerated': isRefrigerated,
  }
  ];

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $myToken',
        'Content-Type': 'application/json', // JSON 요청 본문을 보낼 때 설정
      },
      body: json.encode(requestBody), // 요청 본문을 JSON으로 인코딩
    );

    if (response.statusCode == 200) {
      print('$category send to server successfully');
      // 응답 처리 로직
    } else {
      print('Failed to send data: ${response.statusCode}');
      // 실패 시 처리 로직
    }
  } catch (e) {
    print('Error: ${e.toString()}');
    // 예외 발생 시 처리 로직
  }
}