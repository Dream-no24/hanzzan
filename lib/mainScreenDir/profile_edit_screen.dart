import 'package:hanzzan/mainScreenDir/profile_image_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io'; // File? 을 사용하기 위한 import

class ProfileEditScreen extends StatefulWidget {
  final String profileEdit_email; // 프로필화면에서 전달받은 이메일
  ProfileEditScreen({required this.profileEdit_email});

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();
  File? _profileImage; // 프로필 이미지 저장 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 60,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      '프로필 수정',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        _updateProfile(); // 저장 버튼 클릭 시 프로필 업데이트 호출
                        print("저장하기 버튼을 클릭하였습니다...");

                        // 이전 화면으로 돌아가면서 _profileImage를 반환함
                        Navigator.pop(context, _profileImage);
                      },
                      child: Text(
                        '저장하기',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.topCenter,
                child:
                // 이미지 버튼을 사용한 프로필 이미지 변경
                // 이미지 버튼을 사용한 원형 프로필 이미지 변경
                GestureDetector(
                  onTap: () async {
                    // 이미지 수정 화면으로 이동. 만약 이미지를 수정했다면 해당 이미지가 이 화면으로 전달됨.
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileImageEditScreen()),
                    );
                    // 반환된 결과를 처리하여 프로필 이미지로 설정
                    if (result != null && result is File) {
                      setState(() {
                        _profileImage = result; // 반환된 이미지를 저장
                      });
                    }
                  },
                  // 이미지를 원모양으로 잘라냄.
                  child: ClipOval(
                    child: _profileImage != null
                        ? Image.file(
                      _profileImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      'assets/userImage.png', // 이미지가 설정되어있지 않은 경우 기본 이미지가 나옴.
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이름',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '이름을 입력하세요',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '자기소개',
                      style: TextStyle(fontSize: 18),
                    ),
                    TextField(
                      controller: _profileController,
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '자기소개를 입력하세요',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 서버와의 통신을 위한 함수. 저장하기 버튼 클릭시 동작함.
  Future<void> _updateProfile() async {
    final String url = "http://52.91.27.15:3000/api/users/update";
    String userId = widget.profileEdit_email; // 사용자 계정이 id가 됨. 계정은 프로필화면에서 넘겨받은 값임.
    String username = _nameController.text;     // 이름 변경창에 입력한 텍스트가 name이 됨.
                                                // 근데 어짜피 이름은 서버로 보낼때 계정으로 보낼꺼라서 의미없는 코드임.
    String userprofile = _profileController.text; // 자기소개 변경창에 입력한 텍스트가 userprofile이 됨.

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "userid": userId,   // userid는 사용자 계정이므로 계정을 보냄
          "username": userId, // 이름은 사용자 계정이고 이름은 변경하지 않기로 했으므로 얘도 계정을 보냄
          "userprofile": userprofile, // 화면에서 수정한 userprofile(자기소개 텍스트)를 보냄
        }),
      );

      if (response.statusCode == 200) {
        // 성공적으로 업데이트된 경우 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('200.프로필이 성공적으로 업데이트되었습니다.')),
        );
        print("프로필이 성공적으로 업데이트 되었습니다...");
      } else if (response.statusCode == 400){
        // 서버 오류 처리 - 400 필드누락
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필 업데이트 실패(400필드누락): ${response.reasonPhrase}')),
        );
        print("프로필 업데이트에 실패하였습니다.(400 필드누락)");
      }
      else if (response.statusCode == 500){
        // 서버 오류 처리 - 500 서버오류
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필 업데이트 실패(500서버오류): ${response.reasonPhrase}')),
        );
        print("프로필 업데이트에 실패하였습니다.(500 서버오류)");
      }

    } catch (e) {
      // 네트워크 오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
      print("프로필 업데이트에 실패하였습니다. - 네트워크 오류 발생");
    }
  }
}
