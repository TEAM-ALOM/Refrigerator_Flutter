import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:refrigerator_frontend/models/user_auth.dart';


// ingredietn에 재료 이름 넣으면 id string으로 반환해주는 함수,,
// 백엔드 짬처리^^

Future<String> getIngredientId(String ingredient) async {
  final Uri url = Uri.parse('http://43.201.84.66:8080/api/ingredients/search?keyword=$ingredient');
  String? myToken = await getAccessToken();
  String id = "0"; // 기본값 설정

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $myToken',
      },
    );

    if (response.statusCode == 200) {
      // JSON 응답을 파싱
      final List<dynamic> data = json.decode(response.body);
      print(data);

      if (data.isNotEmpty) {
        // 첫 번째 항목의 'id' 값을 추출
        id = data[0]['id'].toString();
      }
    } else {
      print('Failed to load data: ${response.statusCode}'); // 상태 코드가 200이 아닌 경우
    }
  } catch (e) {
    print('Error: ${e.toString()}'); // 예외 발생 시
  }

  return id; // 결과로 'id' 값을 반환
}
