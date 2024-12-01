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

  bool _isHanyangEmail = true; // 한양 메일 체크 상태
  bool _isVerificationSent = false; // 인증번호 발송 여부

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
              SizedBox(height: 16),
              // 이메일 입력 필드
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '이메일',
                  border: OutlineInputBorder(),
                  errorText: _isHanyangEmail ? null : '*한양 메일을 입력해주세요.',
                ),
                onChanged: (value) {
                  _viewModel.email = value;
                  setState(() {
                    if (value.contains('@')) {
                      final atIndex = value.indexOf('@');
                      final afterAt = value.substring(atIndex + 1);
                      if (afterAt.isNotEmpty && afterAt[0] != 'h') {
                        _isHanyangEmail = false;
                      } else {
                        _isHanyangEmail = true;
                      }
                    } else {
                      _isHanyangEmail = true;
                    }
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _isHanyangEmail = _emailController.text.endsWith('@hanyang.ac.kr');
                    if (!_isHanyangEmail) {
                      FocusScope.of(context).unfocus();
                    }
                  });
                },
              ),
              SizedBox(height: 16),
              // 인증번호 보내기 버튼
              ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.endsWith('@hanyang.ac.kr')) {
                    try {
                      await _viewModel.sendVerificationCode();
                      setState(() {
                        _isVerificationSent = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('인증번호가 발송되었습니다.')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('인증번호 발송 실패: ${e.toString()}')),
                      );
                    }
                  } else {
                    setState(() {
                      _isHanyangEmail = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('*한양 메일을 입력해주세요.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('인증번호 보내기'),
              ),
              SizedBox(height: 16),
              // 인증번호 입력 필드 (인증번호가 발송된 후에만 활성화)
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: '인증번호',
                  border: OutlineInputBorder(),
                ),
                enabled: _isVerificationSent,
                onChanged: (value) {
                  _viewModel.verificationCode = value;
                },
              ),
              SizedBox(height: 16),
              // 인증하기 버튼 (인증번호가 발송된 후에만 활성화)
              ElevatedButton(
                onPressed: _isVerificationSent
                    ? () async {
                  if (!_emailController.text.endsWith('@hanyang.ac.kr')) {
                    setState(() {
                      _isHanyangEmail = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('*한양 메일을 입력해주세요.')),
                    );
                    return;
                  }
                  try {
                    await _viewModel.verifyCode();
                    setState(() {}); // 화면 갱신을 위해 상태 업데이트
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: _viewModel.isCodeVerified ? Text('인증 성공') : Text('인증 실패')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('인증 실패: ${e.toString()}')),
                    );
                  }
                }
                    : null,
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
                  if (!_emailController.text.endsWith('@hanyang.ac.kr')) {
                    setState(() {
                      _isHanyangEmail = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('*한양 메일을 입력해주세요.')),
                    );
                    return;
                  }
                  try {
                    bool isRegistered = await _viewModel.registerUser(_emailController.text);
                    if (isRegistered) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('회원가입 성공')),
                      );
                      Navigator.pop(context); // 회원가입 성공 시 이전 페이지로 돌아감
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('회원가입 실패: 이메일 인증 필요')),
                      );
                    }
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
