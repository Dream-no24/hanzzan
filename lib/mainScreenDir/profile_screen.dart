import 'package:flutter/material.dart';
import 'package:hanzzan/UserInfo/loginPage/login.dart';
import 'package:hanzzan/mainScreenDir/main_screen.dart';
import 'package:hanzzan/mainScreenDir/profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃 확인'),
          content: Text('정말 로그아웃하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
              child: Text('로그아웃'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => pop()),
            ); */ // 뒤로가기 버튼 클릭 시 메인 화면으로 이동
          },
        ),
      ),
      body: Column(
        children: [

          Expanded(
            child: SingleChildScrollView( // 스크롤 가능한 위젯 추가
              child: Container(
                color: Colors.white, // 최상위 Container의 배경색을 흰색으로 설정
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 사용자 아이콘과 텍스트 그룹 묶음
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 사용자 아이콘
                        Icon(
                          Icons.person,
                          size: 120,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 60), // 간격
                        // 텍스트 그룹 묶음
                        Row(
                          children: [
                            // 첫 번째 텍스트 그룹
                            _buildInfoGroup("36.5", "온도"),
                            SizedBox(width: 60),
                            // 두 번째 텍스트 그룹
                            _buildInfoGroup("2", "게시물"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // 사용자 소개 텍스트
                    Text(
                      "자기소개 텍스트\n"
                          "이름: 홍길동\n"
                          "성별: 남\n"
                          "나이: 23\n"
                          "학과: ICT융합학부\n"
                          "연락처: 010-0000-0000\n\n"
                          "밥먹을 사람 연락ㄱㄱ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        width: 400,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileEditScreen()),
                            );
                          },
                          child: Text(
                            "프로필 수정",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey, // 텍스트 색상 설정
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // 로그아웃 버튼
                    Center(
                      child: TextButton(
                        onPressed: () {
                          _showLogoutConfirmationDialog(context);
                        },
                        child: Text(
                          '로그아웃',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGroup(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
