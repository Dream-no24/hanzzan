// 뷰 파일: mypage_view.dart
// 로그인한 사용자의 정보를 보여주는 마이페이지 화면 클래스입니다.
import 'package:flutter/material.dart';
import 'package:hanzzan/UserInfo/loginPage/login.dart';

class MyPageView extends StatefulWidget {
  final String userName;
  final String profilePictureUrl;

  MyPageView({required this.userName, required this.profilePictureUrl});

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 프로필 사진
              CircleAvatar(
                radius: 60,
                backgroundImage: widget.profilePictureUrl.isNotEmpty
                    ? NetworkImage(widget.profilePictureUrl)
                    : AssetImage('assets/default_profile.png') as ImageProvider,
              ),
              SizedBox(height: 16),
              // 사용자 이름
              Text(
                widget.userName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              // 로그아웃 버튼 (로그아웃 시 로그인 페이지로 이동)
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                        (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  '로그아웃',
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
    );
  }
}
