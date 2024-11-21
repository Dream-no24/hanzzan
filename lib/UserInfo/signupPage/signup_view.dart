// 뷰 파일: signup_view.dart
// 사용자와 상호작용하는 UI를 제공하는 클래스입니다.
import 'package:flutter/material.dart';
import 'signup_viewmodel.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final SignUpViewModel _viewModel = SignUpViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        centerTitle: true,
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
                onChanged: (value) {
                  _viewModel.email = value;
                },
              ),
              SizedBox(height: 16),
              // 인증번호 보내기 버튼
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _viewModel.sendVerificationCode();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('인증번호가 발송되었습니다.')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('인증번호 발송 실패: ${e.toString()}')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('인증번호 보내기'),
              ),
              SizedBox(height: 16),
              // 인증번호 입력 필드
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: '인증번호',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _viewModel.verificationCode = value;
                },
              ),
              SizedBox(height: 16),
              // 인증하기 버튼
              ElevatedButton(
                onPressed: () async {
                  try {
                    await _viewModel.verifyCode();
                    setState(() {});  // 화면 갱신을 위해 상태 업데이트
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: _viewModel.isCodeVerified ? Text('인증 성공') : Text('인증 실패')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('인증 실패: ${e.toString()}')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('인증하기'),
              ),
              SizedBox(height: 16),
              // 비밀번호 입력 필드 (인증 전에 비활성화 상태로 표시)
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                enabled: _viewModel.isCodeVerified,
                onChanged: (value) {
                  _viewModel.password = value;
                },
              ),
              SizedBox(height: 16),
              // 회원가입 버튼 (인증 성공 시 활성화)
              ElevatedButton(
                onPressed: _viewModel.isCodeVerified
                    ? () async {
                  try {
                    await _viewModel.registerUser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('회원가입 성공')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('회원가입 실패: ${e.toString()}')),
                    );
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 입력 필드 컨트롤러 해제
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
