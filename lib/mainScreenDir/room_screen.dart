// 현재 모임에 참여 중인 사용자들을 보여주는 클래스 입니다.
// 게시물 클릭 시 이 화면이 나옵니다.
// 참가하기 버튼을 통해 모임에 참가할 수 있습니다.

import 'package:flutter/material.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  // 참가하기와 나가기 버튼을 구분하는 변수
  bool isJoined = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 상단 바: 뒤로가기 버튼, 게시물 제목, 참가하기/나가기 버튼
          Container(
            height: 60,
            color: Colors.grey,
            child: Stack(
              children: [
                // 뒤로가기 버튼: 메인화면으로 돌아감.
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // 게시물 제목(모임 이름)
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'room name',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                // 참가하기/나가기 버튼: 화면에 본인의 프로필 정보가 요약된 컨테이너를 추가/제거함.
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // 참가하기 버튼을 클릭시 isJoined가 true로 변경됨.
                      // 이에 따라 텍스트가 "나가기"로 변경됨.
                      setState(() {
                        isJoined = !isJoined;
                      });
                    },
                    child: Text(
                      // 참가하기 버튼을 클릭할 때마다 isJoined 변수가 변경되면서 텍스트가 바뀜.
                      isJoined ? '나가기' : '참가하기',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          // 사용자 프로필 요약 컨테이너 (참가하기/나가기 버튼을 통해 추가/제거됨)
          // 컨테이너는 화면 상단에 생성됨.
          if (isJoined)
            Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // 사용자 프로필 사진: 지금은 일단 회색 원을 배치했음.
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(width: 20),
                  // 사용자 이름
                  Text(
                    '사용자 이름',
                    style: TextStyle(fontSize: 24),
                  ),
                  Spacer(),
                  // 사용자 온도
                  Text(
                    '36.5',
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}