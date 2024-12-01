import 'package:flutter/material.dart';
import 'package:hanzzan/UserInfo/loginPage/login.dart';
import 'package:hanzzan/mainScreenDir/profile_screen.dart';
import 'package:hanzzan/mainScreenDir/addPost/addPost.dart';
import 'package:hanzzan/mainScreenDir/room_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final String _baseUrl = 'http://52.91.27.15:3000/api';
  List<Post> _posts = []; // 게시물의 정보들을 저장하는 리스트

  @override
  void initState() {
    super.initState();
    _fetchThreads(); // 초기화 시 서버로부터 쓰레드 목록을 불러옴
  }

  Future<void> _fetchThreads() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/thread/list'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> threads = data['thread'] ?? []; // Null일 경우 빈 리스트 처리

        setState(() {
          _posts = threads.map((threadData) {
            // 태그 파싱 (' 1qvk4f '로 나눠 태그 리스트를 생성)
            List<String> tags = threadData['tag'] != null
                ? threadData['tag'].toString().split(' 1qvk4f ')
                : [];

            return Post(
              title: threadData['content'] ?? '제목 없음',
              place: threadData['place'] ?? '장소 미지정',
              time: threadData['threadtime'] != null
                  ? DateTime.parse(threadData['threadtime'])
                  .toLocal()
                  .toString()
                  .substring(0, 16) // YYYY-MM-DD HH:MM 형식
                  : '시간 미지정',
              purpose: threadData['content'] ?? '목적 미지정',
              hashtags: tags,
            );
          }).toList();
        });
      } else {
        print('Error: 서버 오류로 인해 쓰레드 목록을 불러올 수 없습니다.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
                final newPost = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPost()),
                );
                if (newPost != null && newPost is Post) {
                  setState(() {
                    _posts.add(newPost);
                  });
                }
              },
              icon: Icon(Icons.add),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                } else {
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
      body: RefreshIndicator(
        onRefresh: _fetchThreads, // 당겨서 새로고침 시 쓰레드 목록 다시 불러오기
        child: Container(
          color: Colors.white,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              final post = _posts[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoomScreen()),
                  );
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/ERICA.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Text(
                          post.time,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
                        bottom: 10,
                        left: 20,
                        child: Text(
                          post.place,
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
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
                        right: 10,
                        top: 10,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/profile.jpg'),
                          radius: 25,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: post.hashtags.map((hashtag) {
                            return Text(
                              '# $hashtag',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
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
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: _buildFilterButton(context),
    );
  }

  bool _isUserLoggedIn() {
    return true;
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

class Post {
  final String title;
  final String place;
  final String time;
  final String purpose;
  final List<String> hashtags;

  Post({required this.title, required this.place, required this.time, required this.purpose, required this.hashtags});
}
