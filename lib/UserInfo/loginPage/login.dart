// 뷰 파일: login_view.dart
// 사용자와 상호작용하는 UI를 제공하는 로그인 화면 클래스입니다.
import 'package:flutter/material.dart';
import '../signupPage/signup_view.dart';
import '../signupPage/signup_viewmodel.dart';
import 'package:hanzzan/mainScreenDir/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignUpViewModel _viewModel = SignUpViewModel();

  // 서버 URL
  final String _baseUrl = 'http://52.91.27.15:3000/api';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 외의 부분을 터치하면 키보드 닫힘
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('로그인'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              ); // 뒤로가기 버튼 클릭 시 메인 화면으로 이동
            },
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 이메일 입력 필드
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {},
                ),
                SizedBox(height: 16),
                // 비밀번호 입력 필드
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  onChanged: (value) {},
                ),
                SizedBox(height: 16),
                // 로그인 버튼
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _loginUser();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('로그인 성공')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      ); // 로그인 성공 시 메인 화면으로 이동
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('로그인 실패: ${e.toString()}')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('로그인'),
                ),
                SizedBox(height: 16),
                // 회원가입 페이지로 이동 버튼
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                  child: Text(
                    '회원가입이 필요하신가요?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 로그인 사용자 메서드 구현
  Future<void> _loginUser() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      print('로그인 성공: ${_emailController.text}');
    } else if (response.statusCode == 400) {
      throw Exception('로그인 실패: 이메일 또는 비밀번호 오류');
    } else if (response.statusCode == 401) {
      throw Exception('로그인 실패: 존재하지 않는 사용자');
    } else {
      throw Exception('로그인 실패: ${response.reasonPhrase}');
    }
  }

  @override
  void dispose() {
    // 입력 필드 컨트롤러 해제
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
