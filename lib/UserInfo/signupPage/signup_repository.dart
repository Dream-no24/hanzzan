// 리포지토리 파일: signup_repository.dart
// 실제로 데이터와 상호작용하는 부분을 담당합니다. (예: 서버 요청, DB 처리 등)
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpRepository {
  // 서버 URL
  final String _baseUrl = 'http://52.91.27.15';

  // 사용자의 이메일로 인증번호를 발송하는 메서드
  Future<bool> sendVerificationCode(String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/send-verification'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      print('인증 메일이 $email 로 발송되었습니다.');
      return true;
    } else {
      print('인증번호 발송 실패: ${response.reasonPhrase}');
      return false;
    }
  }

  // 인증 코드를 확인하는 메서드
  Future<bool> verifyCode(String email, String code) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      print('인증이 완료되었습니다.');
      return true;
    } else {
      print('인증 실패: ${response.reasonPhrase}');
      return false;
    }
  }

  // 사용자를 등록하는 메서드
  Future<bool> registerUser(String userId, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userid': userId,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('$email 사용자 등록 완료.');
      return true;
    } else if (response.statusCode == 401) {
      print('이메일 인증이 필요합니다.');
      return false;
    } else {
      print('사용자 등록 실패: ${response.reasonPhrase}');
      return false;
    }
  }
}
