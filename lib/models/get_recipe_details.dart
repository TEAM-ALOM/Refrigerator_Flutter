import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:refrigerator_frontend/models/user_auth.dart';

// 음식 이름 넣으면 Recipe객체 반환


// 레시피 상세 정보를 담고 있는 객체
class Recipe {
  final String id; // 레시피 아이디
  final String title; // 레시피 이름
  final String category; // 레시피 카테고리
  final String thumbnail; // 레시피 썸네일
  final List<Map<String, bool>> ingredientList; // 재료 배열 (재료이름, 보유여부)

  Recipe({
    required this.id,
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.ingredientList,
  });
}




Future<void> getRecipeDetails(String name) async {
  final Uri url = Uri.parse('http://43.201.84.66:8080/api/recipe/search?keyword=$name');
  String? myToken = await getAccessToken();

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $myToken',
      },
    );

    if (response.statusCode == 200) {
      // JSON 응답을 파싱
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      print(data);


    } else {
      print('Failed to load data: ${response.statusCode}'); // 상태 코드가 200이 아닌 경우
    }
  } catch (e) {
    print('Error: ${e.toString()}'); // 예외 발생 시
  }

  return ; // 결과로 'id' 값을 반환
}
