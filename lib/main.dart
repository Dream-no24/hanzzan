import 'package:flutter/material.dart';
import 'package:hanzzan/mainScreenDir/profile_edit_screen.dart';
import 'package:hanzzan/mainScreenDir/room_screen.dart';
import 'mainScreenDir/main_screen.dart';
import 'mainScreenDir/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: MainScreen(),
      home: MainScreen()

    );
  }
}