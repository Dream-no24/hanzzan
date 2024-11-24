import 'package:flutter/material.dart';
import 'package:hanzzan/mainScreenDir/main_screen.dart';

class AddPost extends StatefulWidget {
  final int maxHashtags = 3;
  final int maxHashtagLength = 10;

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  int _selectedHour = 0;
  int _selectedMinute = 0;
  FixedExtentScrollController _hoursController = FixedExtentScrollController();
  FixedExtentScrollController _minutesController = FixedExtentScrollController();

  TextEditingController _titleController = TextEditingController();
  String _selectedPlace = '';
  String _selectedPurpose = '';
  List<TextEditingController> _hashtagControllers = [];

  @override
  void initState() {
    super.initState();
    _hashtagControllers = List.generate(widget.maxHashtags, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: Text(
          '게시물 추가',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
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
            SizedBox(height: 11),
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
            SizedBox(height: 2),
            // 게시 버튼
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 게시물 추가 로직
                  String title = _titleController.text;
                  String time = "${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')}";
                  List<String> hashtags = _hashtagControllers.map((controller) => controller.text).where((tag) => tag.isNotEmpty).toList();

                  Post newPost = Post(
                    title: title,
                    place: _selectedPlace,
                    time: time,
                    purpose: _selectedPurpose,
                    hashtags: hashtags,
                  );

                  Navigator.pop(context, newPost);
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
      width: 60,
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
      width: 60,
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
  final String title;
  final String place;
  final String time;
  final String purpose;
  final List<String> hashtags;

  Post({required this.title, required this.place, required this.time, required this.purpose, required this.hashtags});
}

void main() => runApp(MaterialApp(
  home: AddPost(),
));
