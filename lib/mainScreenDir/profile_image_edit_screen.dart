// 사용자가 프로필 사진을 변경하는 화면입니다.

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileImageEditScreen extends StatefulWidget {
  @override
  _ProfileImageEditScreenState createState() => _ProfileImageEditScreenState();
}

class _ProfileImageEditScreenState extends State<ProfileImageEditScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: Text(
          '프로필 사진 변경',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            // 선택한 프로필 사진 보여주기
            CircleAvatar(
              radius: 80,
              backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
              child: _selectedImage == null
                  ? Icon(
                Icons.person,
                size: 100,
                color: Colors.grey,
              )
                  : null,
            ),
            SizedBox(height: 30),
            // 사진 변경 버튼
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('사진 선택하기'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
            Spacer(),
            // 저장 버튼
            ElevatedButton(
              onPressed: () {
                // 프로필 사진 저장 기능 (나중에 구현)
                Navigator.pop(context, _selectedImage);
              },
              child: Text('저장하기'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
