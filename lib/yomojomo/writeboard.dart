import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WriteBoard extends StatefulWidget {

  @override
  State<WriteBoard> createState() => _WriteBoardState();
}

class _WriteBoardState extends State<WriteBoard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _userEmail; // 로그인한 사용자의 이메일
  String? _jwtToken;

  @override
  void initState() {
    super.initState();
    _loadUserEmail(); // 사용자 이메일 불러오기
    _loadToken();
  }
  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEmail = prefs.getString('userEmail');
    });
  }
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _jwtToken = prefs.getString('jwtToken');
    });
  }
  Future<void> _savePost() async {
    String title = _titleController.text;
    String content = _contentController.text;

    DateTime write_datetime = DateTime.now();

    final String uri = 'http://10.0.2.2:4000/api/v1/board';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_jwtToken',
    };
    Map<String, dynamic> postData = {
      'title': title,
      'content': content,
      'write_datetime': write_datetime.toIso8601String(), // ISO 8601 포맷으로 시간을 전송
      'writer_email': _userEmail, // 작성자 이메일
    };
    String requestBody = json.encode(postData);

    try {
      // 서버에 POST 요청 보내기
      http.Response response = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: requestBody,
      );
      // 요청이 성공했을 때
      if (response.statusCode == 200) {
        print('게시글이 성공적으로 등록되었습니다.');
      } else {
        print("email ${_userEmail}");
        print('게시글 등록에 실패했습니다. 오류 코드: ${response.statusCode}');
      }
    } catch (error) {
      // 네트워크 오류 등의 예외 처리
      print('게시글 등록 중 오류가 발생했습니다: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: '제목',
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: '내용',
              ),
              maxLines: null,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _savePost,
              child: Text('게시글 등록'),
            ),
          ],
        ),
      ),
    );
  }
}
