import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/mainScreenDir/main_screen.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _baseUrl = 'http://52.91.27.15:3000/api';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _loginUser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('로그인 성공')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        // 메인화면과 연결되는 모든 화면에서 사용하는 사용자 아이디(계정)는 여기서 결정됨.
                        // 즉, 사용자 아이디는 서버로부터 받아오는 것이 아닌 로그인 창에서 내가 입력한 값으로 사용하게됨.
                        builder: (context) => MainScreen(main_email: _emailController.text),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('로그인 실패: ${e.toString()}')),
                    );
                  }
                },
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
