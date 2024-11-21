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
                          // 우측 사용자 정보
                          Row(
                            children: [
                              const Text(
                                'NAME', // 추가된 텍스트
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 5), // 텍스트와 아이콘 간 간격
                              Icon(
                                Icons.person, // 사용자 아이콘
                                size: 30,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // 게시물 내용 (이미지 배경)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/ERICA.jpg'), // 이미지 파일 경로
                            fit: BoxFit.cover, // 이미지를 박스에 맞게 채움
                          ),
                        ),
                        child: Stack(
                          children: [
                            // 좌측 상단 시간 텍스트
                            Positioned(
                              left: 10, // 좌측 여백
                              top: 10, // 상단 여백
                              child: const Text(
                                '시간: 12:00 ~ 13:00',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white, // 흰색 텍스트
                                ),
                              ),
                            ),
                            // 좌측 하단 해시태그 텍스트
                            Positioned(
                              left: 10, // 좌측 여백
                              bottom: 10, // 하단 여백
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '# 시험 전 달릴 사람들',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white, // 흰색 텍스트
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '# 마지막 불꽃',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white, // 흰색 텍스트
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '# 장소 역할맥',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white, // 흰색 텍스트
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
