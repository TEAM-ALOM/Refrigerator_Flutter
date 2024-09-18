import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// SecureStorage 인스턴스 생성
const _storage = FlutterSecureStorage();

// 토큰 저장
Future<void> saveTokens(String accessToken, String refreshToken) async {
  await _storage.write(key: 'access_token', value: accessToken);
  await _storage.write(key: 'refresh_token', value: refreshToken);
}

// 액세스 토큰 불러오기
Future<String?> getAccessToken() async {
  return await _storage.read(key: 'access_token');
}

// 리프레시 토큰 불러오기
Future<String?> getRefreshToken() async {
  return await _storage.read(key: 'refresh_token');
}

// 토큰 삭제
Future<void> deleteTokens() async {
  await _storage.delete(key: 'access_token');
  await _storage.delete(key: 'refresh_token');
}

// 엑세스 토큰 재발급
Future<bool> refreshAccessToken() async {
  Uri url = Uri.parse('http://43.201.84.66:8080/api/refresh');
  try {
    String? refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      print('No refresh token found for user.');
      return false;
    }

    final response = await http.post(
      url,
      headers: {'refresh': refreshToken, "Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      //print('토큰 재발급 성공');
      final newAccessToken = response.headers['access'];
      final newRefreshToken = response.headers['refresh'];

      await saveTokens(newAccessToken!, newRefreshToken!);

      print('Token refreshed successfully.');
      return true;
    }

    // refresh 만료 -> 강제 로그아웃시키기
    else if (response.statusCode == 401) {
      print('refresh 만료');
      deleteTokens();

      return false;
    }
  } catch (e) {
    print('Token refresh failed: $e');
  }
  return false;
}
