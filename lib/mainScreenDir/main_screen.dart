import 'package:flutter/material.dart';
import 'package:hanzzan/UserInfo/loginPage/login.dart';
import 'package:hanzzan/mainScreenDir/profile_screen.dart';
import 'package:hanzzan/mainScreenDir/addPost/addPost.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 게시물의 정보들을 저장하는 리스트
  // 게시물 추가하기 화면(addPost.dart)에서 입력값 설정 후 추가하기 버튼을 누르면
  // 입력값들을 모아둔 객체가 여기에 저장됨.
  List<Post> _posts = [];

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
              onPressed: () async {
                // 게시물 추가 페이지로 이동
                final newPost = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPost()),
                );

                // 게시물 추가 페이지에서 반환된 값이 있을 경우 리스트에 추가
                if (newPost != null && newPost is Post) {
                  setState(() {
                    _posts.add(newPost);
                  });
                }
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
          itemCount: _posts.length, // 게시물 저장 리스트 크기만큼 보여줌
          itemBuilder: (context, index) {
            final post = _posts[index];

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
                    child: Text(
                      // 게시물 추가 화면에서 지정한 시간을 표시
                      post.time,
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
                    child: Text(
                      // 게시물 추가하기 화면에서 지정한 장소를 표시
                      post.place,
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
                      children: post.hashtags.map((hashtag) {
                        return Text(
                          // 게시물 추가하기 화면에서 지정한 헤시태그를 표시
                          // 헤시태그가 여러개일 경우 자동으로 한개씩 추가됨.
                          '# $hashtag',
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
                        );
                      }).toList(),
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
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
      position: RelativeRect.fromLTRB(offset.dx, offset.dy - 80, offset.dx, 0),
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
      color: Colors.white,
    ).then((value) {
      if (value != null) {
        print('$filterType 옵션 $value 선택됨');
      }
    });
  }
}
