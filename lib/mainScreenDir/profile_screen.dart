import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 상단 배너
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back),
                  iconSize: 40,
                  color: Colors.black87,
                ),
                Text(
                  "Profile Screen",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 48),
              ],
            ),
          ),
          // 나머지 부분
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
                            Container(
                              padding:
                              const EdgeInsets.symmetric(vertical: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "36.5",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "온도",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 60),
                            // 두 번째 텍스트 그룹
                            Container(
                              padding:
                              const EdgeInsets.symmetric(vertical: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "2",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "게시물",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                          onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
