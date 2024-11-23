// 사용자의 프로필을 수정하는 클래스 입니다.

import 'package:flutter/material.dart';
import 'package:hanzzan/mainScreenDir/main_screen.dart';

class ProfileEditScreen extends StatelessWidget {
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
              // 상단 바: 뒤로가기 버튼, 화면의 이름, 저장하기 버튼을 포함.
              Container(
                height: 60,
                color: Colors.grey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 뒤로가기 버튼: 변경 중인 내용을 취소하고 프로필 화면으로 돌아감
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // 화면의 이름
                    Text(
                      '프로필 수정',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // 저장하기 버튼: 수정한 내용을 저장하고 프로필 화면으로 돌아감
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // 저장하기 기능은 나중에 구현
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
              // 프로필 사진 변경 버튼
              Container(
                alignment: Alignment.topCenter,
                child: IconButton(
                  icon: Icon(
                    Icons.person,
                    size: 100,
                  ),
                  onPressed: () {}, // 프로필 사진 변경 기능은 나중에 구현
                ),
              ),

              SizedBox(height: 30),
              // 사용자 이름 변경 칸
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '이름',
                      style: TextStyle(fontSize: 18),
                    ),
                    // 이름 입력창
                    TextField(
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '이름을 입력하세요',
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),
              // 자기소개 입력칸
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '자기소개',
                      style: TextStyle(fontSize: 18),
                    ),
                    // 자기소개 입력창
                    TextField(
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      autofocus: true,
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
}