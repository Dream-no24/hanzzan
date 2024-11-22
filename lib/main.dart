import 'package:flutter/material.dart';
import 'mainScreenDir/main_screen.dart';
import 'mainScreenDir/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      // home: ProfileScreen(), // 프로필 화면을 보기 위한 코드 변경

    );
  }
}