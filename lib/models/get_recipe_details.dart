import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:refrigerator_frontend/models/user_auth.dart';




// 레시피 상세 정보를 담고 있는 객체
class Recipe {
  String id; // 레시피 아이디
  String title; // 레시피 이름
  String category; // 레시피 카테고리
  String thumbnail; // 레시피 썸네일
  List<Map<String, bool>> ingredientList; // 필요한 재료 배열 (재료이름, 보유여부)

  // 기본 생성자
  Recipe()
      : id = '',
        title = '',
        category = '',
        thumbnail = '',
        ingredientList = [];

// Recipe 멤버값 채우는 메서드
  void setRecipe(String id, String title, String category, String thumbnail,
      List<Map<String, bool>> ingredientList) {
    this.id = id;
    this.title = title;
    this.category = category;
    this.thumbnail = thumbnail;
    this.ingredientList = ingredientList;
  }

  void printRecipe(){
    print(id);
    print(title);
    print(category);
    print(thumbnail);
    print(ingredientList.toString());
  }

}






// foodName에 해당하는 레시피 정보를 Recipe 객체로 반환
// 음식 이름 넣으면 레시피 정보를 Recipe객체로 반환
Future<void> getRecipeDetails(String foodName) async {

  final Uri url = Uri.parse('http://43.201.84.66:8080/api/recipe/search?keyword=$foodName');
  String? myToken = await getAccessToken();
  Recipe myRecipe = new Recipe();

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
      Map <String, dynamic> firstData = data[0];
      myRecipe.setRecipe(firstData['id'].toString(), firstData['title'],
          firstData['category'], firstData['thumbnail'], firstData['ingredientList']);
    } else {
      print('Failed to load data: ${response.statusCode}'); // 상태 코드가 200이 아닌 경우
    }
  } catch (e) {
    print('Error: ${e.toString()}'); // 예외 발생 시
  }

  return ; // 결과로 'id' 값을 반환
}


