// 리포지토리 파일: signup_repository.dart
// 실제로 데이터와 상호작용하는 부분을 담당합니다. (예: 서버 요청, DB 처리 등)
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpRepository {
  // 서버 URL
  final String _baseUrl = 'https://your-api-server.com/api';

  // 사용자의 이메일로 인증번호를 발송하는 메서드
  Future<void> sendVerificationCode(String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/send_verification_code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print('인증번호가 $email 로 발송되었습니다.');
    } else {
      throw Exception('인증번호 발송 실패: ${response.reasonPhrase}');
    }
  }

  // 인증 코드를 확인하는 메서드
  Future<bool> verifyCode(String email, String code) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/verify_code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['verified'] == true;
    } else {
      throw Exception('인증 실패: ${response.reasonPhrase}');
    }
  }

  // 사용자를 등록하는 메서드
  Future<void> registerUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register_user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('$email 사용자 등록 완료.');
    } else {
      throw Exception('사용자 등록 실패: ${response.reasonPhrase}');
    }
  }
}