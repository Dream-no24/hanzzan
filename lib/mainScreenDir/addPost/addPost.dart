import 'package:flutter/material.dart';
import 'package:hanzzan/mainScreenDir/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io'; // File? 을 사용하기 위한 import

class AddPost extends StatefulWidget {
  final int maxHashtags = 3;
  final int maxHashtagLength = 10;

  final String addPost_email; // 메인 화면에서 전달받은 이메일
  final File? addPost_profileImage; // 메인 화면에서 전달받은 프로필 이미지

  AddPost({required this.addPost_email, required this.addPost_profileImage});

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _maxParticipants = 2; // 최대 참가자 수 초기값
  FixedExtentScrollController _hoursController = FixedExtentScrollController();
  FixedExtentScrollController _minutesController = FixedExtentScrollController();

  TextEditingController _titleController = TextEditingController();
  String _selectedPlace = '';
  String _selectedPurpose = '';
  List<TextEditingController> _hashtagControllers = [];
  File? _main_profileImage; // 메인화면에서 이용하는 프로필 이미지

  @override
  void initState() {


    super.initState();
    _hashtagControllers = List.generate(widget.maxHashtags, (index) => TextEditingController());
    // 현재 시간을 기본값으로 설정
    DateTime now = DateTime.now();
    _selectedHour = now.hour;
    _selectedMinute = now.minute;
    _hoursController = FixedExtentScrollController(initialItem: _selectedHour);
    _minutesController = FixedExtentScrollController(initialItem: _selectedMinute);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 외의 부분을 터치하면 키보드 닫힘
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          title: Text(
            '게시물 추가',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목 입력 필드
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: '제목',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // 장소 선택 드롭다운
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: '장소',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: 'A+', child: Text('A+')),
                    DropdownMenuItem(value: '은현동포차', child: Text('은현동포차')),
                    DropdownMenuItem(value: '교반', child: Text('교반')),
                    DropdownMenuItem(value: '역전할머니맥주', child: Text('역전할머니맥주')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedPlace = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16),
                // 시간 선택 다이얼로그 대신 커스텀 타임 피커
                _buildTimePicker(),
                SizedBox(height: 16),
                // 목적 선택 드롭다운
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: '목적',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: '점심', child: Text('점심')),
                    DropdownMenuItem(value: '저녁', child: Text('저녁')),
                    DropdownMenuItem(value: '간술', child: Text('간술')),
                    DropdownMenuItem(value: '술', child: Text('술')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedPurpose = value ?? '';
                    });
                  },
                ),
                SizedBox(height: 16),
                // 최대 인원수 선택 슬라이더
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '최대 인원수',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Slider(
                      value: _maxParticipants.toDouble(),
                      min: 2,
                      max: 10,
                      divisions: 8,
                      label: '$_maxParticipants명',
                      onChanged: (value) {
                        setState(() {
                          _maxParticipants = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // 해시태그 입력 필드 (최대 3개, 각 10자 제한)
                Column(
                  children: List.generate(widget.maxHashtags, (index) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.5),
                        child: TextField(
                          controller: _hashtagControllers[index],
                          maxLength: widget.maxHashtagLength,
                          decoration: InputDecoration(
                            labelText: '# 해시태그 ${index + 1}',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                  ),
                ),
                SizedBox(height: 16),
                // 게시 버튼
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _createMeeting();
                    },
                    child: Text('게시물 추가'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // 텍스트와 별표가 같은 줄에 배치
              children: [
                Text(
                  '시간 선택 ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '*', // 별표 기호
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red, // 별표는 빨간색
                  ),
                ),
              ],
            ),
            Text(
              "${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1BB874),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHourPicker(),
            Text(':', style: TextStyle(fontSize: 24, color: Colors.grey)),
            _buildMinutePicker(),
          ],
        ),
      ],
    );
  }

  Widget _buildHourPicker() {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.2, // 화면 크기에 비례하도록 수정
      child: ListWheelScrollView.useDelegate(
        controller: _hoursController,
        itemExtent: 50,
        physics: FixedExtentScrollPhysics(), // 딱딱 멈추게 하는 설정
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedHour = index;
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Text(
                index.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 24,
                  color: index == _selectedHour ? Color(0xFF1BB874) : Color(0xFFC8C8C8),
                  fontWeight: index == _selectedHour ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            );
          },
          childCount: 24,
        ),
      ),
    );
  }

  Widget _buildMinutePicker() {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.2, // 화면 크기에 비례하도록 수정
      child: ListWheelScrollView.useDelegate(
        controller: _minutesController,
        itemExtent: 50,
        physics: FixedExtentScrollPhysics(), // 딱딱 멈추게 하는 설정
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedMinute = index;
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            return Center(
              child: Text(
                index.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 24,
                  color: index == _selectedMinute ? Color(0xFF1BB874) : Color(0xFFC8C8C8),
                  fontWeight: index == _selectedMinute ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            );
          },
          childCount: 60,
        ),
      ),
    );
  }

  Future<void> _createMeeting() async {
    final url = 'http://52.91.27.15:3000/api/thread/create'; // 서버 주소 입력

    // 요청 데이터 구성
    String title = _titleController.text;
    String time = "${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')}";
    List<String> hashtags = _hashtagControllers.map((controller) => controller.text).where((tag) => tag.isNotEmpty).toList();
    // ' 1qvk4f '로 붙이고, 같은 키로 main screen에서 분할
    String combinedHashtags = hashtags.join(' 1qvk4f ');

    Map<String, dynamic> requestBody = {
      "writerid": widget.addPost_email, // 사용자 아이디는 메인화면으로부터 전달받은 이메일이 됨.
      "place": _selectedPlace,
      "tag": combinedHashtags,
      "content": _selectedPurpose,
      "threadtime": time,
      "maxParticipants": _maxParticipants // 최대 참가자 수 반영
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // 게시물 추가 성공 시
        print('쓰레드 생성 성공');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('쓰레드 생성 성공: ${jsonDecode(response.body)['threadId']}')),
        );
        Navigator.pop(context); // 뒤로 가기 (이전 페이지로 돌아가기)
      } else if (response.statusCode == 400) {
        // 필수 필드 누락
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('게시물 추가 실패: 필수 필드가 누락되었습니다.')),
        );
      } else if (response.statusCode == 500) {
        // 서버 오류
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('게시물 추가 실패: 서버 오류 발생')),
        );
      } else {
        // 그 외 오류
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('게시물 추가 실패: ${response.statusCode} 오류')),
        );
      }

      try {
        final responseBody = jsonDecode(response.body);
        print('Response received: $responseBody');
      } catch (e) {
        print('Response is not a valid JSON: ${response.body}');
      }
    } catch (e) {
      // 네트워크 오류 등 기타 오류 처리
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('게시물 추가 실패: 네트워크 오류 또는 서버 응답 없음')),
      );
    }
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _titleController.dispose();
    _hashtagControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}

class Post {
  final String id;
  final String title;
  final String place;
  final String time;
  final String purpose;
  final List<String> hashtags;

  Post({required this.id, required this.title, required this.place, required this.time, required this.purpose, required this.hashtags});
}

//void main() => runApp(MaterialApp(
  //home: AddPost(),
//));
