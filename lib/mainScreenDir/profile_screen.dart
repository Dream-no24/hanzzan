import 'package:flutter/material.dart';
import 'package:hanzzan/UserInfo/loginPage/login.dart';
import 'package:hanzzan/mainScreenDir/main_screen.dart';
import 'package:hanzzan/mainScreenDir/profile_edit_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userId = "tksehdrnf@hanyang.ac.kr"; // 사용자 계정이 id가 됨. 당장은 하드코딩이므로 나중에 변경해야됨.
  String userProfile = "안녕하세요."; // 사용자 자기소개 텍스트의 초기 상태

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); // 사용자 프로필 가져오기
  }

  // 프로필 설정 화면에서 변경한 자기소개 텍스트를 서버로부터 받아서 프로필 화면에 적용시키기 위한 서버 통신 함수.
  Future<void> _fetchUserProfile() async {
    final String url = "http://52.91.27.15:3000/api/users/get-user";
    try {
      // post로 userid를 보냄.
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "userid": userId,
        }),
      );

      // post의 답변으로 userprofile을 받음.
      if (response.statusCode == 200) {
        final data = json.decode(response.body)["thread"][0];
        print("서버 응답: $data");

        setState(() {
          userProfile = data["userprofile"]; // 이게 userprofile임.
        });
      } else {
        print("프로필 불러오기 실패: ${response.statusCode}");
        setState(() {
          userProfile = "프로필 정보를 불러오지 못했습니다.";
        });
      }

    } catch (e) {
      print("프로필 가져오는 중 오류 발생: $e");
      setState(() {
        userProfile = "네트워크 오류로 프로필을 불러올 수 없습니다.";
      });
    }
  }

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
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person,
                          size: 120,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 60),
                        Row(
                          children: [
                            _buildInfoGroup("36.5", "온도"),
                            SizedBox(width: 60),
                            _buildInfoGroup("2", "게시물"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // 사용자 자기소개 텍스트
                    Text(
                      userProfile,    // 서버에서 받은 userprofile이 자기소개 텍스트로 지정됨.
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
                              MaterialPageRoute(
                                  builder: (context) => ProfileEditScreen()),
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
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
