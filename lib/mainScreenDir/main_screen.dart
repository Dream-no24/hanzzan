import 'package:flutter/material.dart';
import 'package:hanzzan/UserInfo/loginPage/login.dart';
import 'package:hanzzan/mainScreenDir/profile_screen.dart';
import 'package:hanzzan/mainScreenDir/addPost/addPost.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                // 게시물 추가 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPost()),
                );
              },
              icon: Icon(Icons.add), // 게시물 추가 아이콘으로 변경
              iconSize: 30,
              color: Colors.black,
            ),
            Text(
              '한짠',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            IconButton(
              onPressed: () {
                if (_isUserLoggedIn()) {
                  // 로그인 상태라면 마이페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                } else {
                  // 로그인 상태가 아니라면 로그인 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                }
              },
              icon: Icon(Icons.person),
              iconSize: 30,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: 6, // 예시로 총 6개의 이미지
          itemBuilder: (context, index) {
            return Container(
              height: 200, // 직사각형 비율 5:2 정도로 설정
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // 테두리 둥글게 설정
                image: DecorationImage(
                  image: AssetImage('assets/ERICA.jpg'), // 이미지 파일 경로
                  fit: BoxFit.cover, // 이미지를 박스에 맞게 채움
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 10, // 좌측 여백
                    top: 10, // 상단 여백
                    child: const Text(
                      '시간: 12:00 ~ 13:00',
                      style: TextStyle(
                        fontSize: 18, // 조금 작게 설정
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // 흰색 텍스트
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10, // 하단 여백
                    left: 20, // 좌측 여백
                    child: const Text(
                      'A+',
                      style: TextStyle(
                        fontSize: 40, // 크게 설정
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // 흰색 텍스트
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10, // 우측 여백
                    top: 10, // 상단 여백
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.jpg'), // 프로필 이미지 파일 경로
                      radius: 25,
                    ),
                  ),
                  Positioned(
                    right: 10, // 우측 여백
                    bottom: 10, // 하단 여백
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '# 시험 전 달릴 사람들',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white, // 흰색 텍스트
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 2.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          '# 라스트댄스',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white, // 흰색 텍스트
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 2.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: _buildFilterButton(context),
    );
  }

  bool _isUserLoggedIn() {
    // 실제 앱에서는 로그인 상태를 저장하는 SharedPreferences, Firebase Auth, 또는 다른 인증 시스템을 사용할 수 있습니다.
    // 여기서는 하드코딩된 값으로 예시를 보여드립니다.
    return true; // 로그인 상태: true, 비로그인 상태: false
  }

  Widget _buildFilterButton(BuildContext context) {
    return FloatingActionButton( // 필터 플로팅 액션 버튼 구현
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 80, // 아이콘만 보일 정도로 바텀시트 높이 설정
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white, // 배경을 하얀색으로 설정
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.access_time),
                    iconSize: 40,
                    onPressed: () {
                      _showPopupMenu(context, '시간', Offset(40, MediaQuery.of(context).size.height - 150));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.place),
                    iconSize: 40,
                    onPressed: () {
                      _showPopupMenu(context, '장소', Offset(150, MediaQuery.of(context).size.height - 150));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.flag),
                    iconSize: 40,
                    onPressed: () {
                      _showPopupMenu(context, '목적', Offset(260, MediaQuery.of(context).size.height - 150));
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Icon(Icons.filter_list),
      backgroundColor: Colors.blue,
    );
  }

  void _showPopupMenu(BuildContext context, String filterType, Offset offset) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy - 80, offset.dx, 0), // 아이콘 위치 기준으로 메뉴 표시, 위로 이동
      items: [
        PopupMenuItem(
          value: 1,
          child: Text('$filterType 옵션 1'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('$filterType 옵션 2'),
        ),
        PopupMenuItem(
          value: 3,
          child: Text('$filterType 옵션 3'),
        ),
      ],
      color: Colors.white, // 메뉴의 배경색을 하얀색으로 설정
    ).then((value) {
      if (value != null) {
        print('$filterType 옵션 $value 선택됨');
      }
    });
  }
}
