import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                print('Clock button pressed');
              },
              icon: Icon(Icons.access_time),
              iconSize: 40,
            ),
            IconButton(
              onPressed: () {
                print('+ button pressed');
              },
              icon: Icon(Icons.add),
              iconSize: 40,
            ),
            IconButton(
              onPressed: () {
                print('User button pressed');
              },
              icon: Icon(Icons.person),
              iconSize: 40,
            ),
          ],
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(
            children: [
              // 게시물 박스
              Container(
                height: 400, // 게시물 높이
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    // 상단 바
                    Container(
                      height: 60, // 상단 바 높이
                      width: double.infinity, // 좌우 가득 채우기
                      color: Colors.grey[200], // 바의 배경색
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 좌측 제목
                          const Text(
                            'title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // 우측 사용자 아이콘
                          Icon(
                            Icons.person, // 사용자 아이콘
                            size: 30,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    // 게시물 내용 (비워둠)
                    Expanded(
                      child: Center(
                        child: Text(
                          '게시물 내용 추가 준비 중...',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
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

