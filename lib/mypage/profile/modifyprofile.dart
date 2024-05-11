import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mojadel2/mypage/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../login/loginpage.dart';

class modifiyProfile extends StatefulWidget {
  const modifiyProfile({super.key});

  @override
  State<modifiyProfile> createState() => _modifiyProfileState();
}

class _modifiyProfileState extends State<modifiyProfile> {
  String? _nickname;
  File? _imageFile;
  ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadNickname();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('프로필편집'),backgroundColor: Colors.lightGreen,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _JoinMembership(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogInPage()),
                ).then(
                      (jwtToken) {
                    if (jwtToken != null) {
                      // 로그인 성공 후 사용자의 닉네임을 가져옴
                      _getNickname(jwtToken).then((nickname) {
                        if (nickname != null) {
                          // 닉네임을 성공적으로 가져왔을 때 상태 업데이트
                          setState(() {
                            _nickname = nickname;
                          });
                        }
                      });
                    }
                  },
                );
              },
              child: Text('로그인'),
            ),
            TextButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('로그아웃 완료'),
                  ),
                );
                await _logout();
              },
              child: Text('로그아웃'),
            ),
            TextButton(
              onPressed: () {
                _getImage(ImageSource.gallery);
              },
              child: Text('프로필 사진 변경'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadNickname() async {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwtToken');
    if (jwtToken != null) {
      final nickname = await _getNickname(jwtToken);
      setState(() {
        _nickname = nickname;
      });
    }
  }

  Future<String?> _getNickname(String jwtToken) async {
    final String uri =
        'http://10.0.2.2:4000/api/v1/user/'; // 사용자 정보를 가져오는 API 엔드포인트
    final Map<String, String> headers = {
      'Authorization': 'Bearer $jwtToken', // JWT 토큰을 인증 헤더에 포함
    };

    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String? nickname = responseData['nickname'];
        return nickname;
      } else {
        // 서버에서 오류 응답을 반환할 경우 처리
        print('Failed to get nickname: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (error) {
      // HTTP 요청 중에 오류가 발생한 경우 처리
      print('Failed to get nickname: $error');
      return null;
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwtToken'); // 토큰 삭제
    setState(() {
      _nickname = null; // 닉네임을 비움
    });
  }

  Future<void> _uploadImage(File imageFile) async {
    final prefs = await SharedPreferences.getInstance();
    final jwtToken = prefs.getString('jwtToken');
    if (jwtToken != null) {
      try {
        // Read the image file as bytes
        List<int> imageBytes = await imageFile.readAsBytes();
        // Encode the image bytes to BASE64 string
        String base64Image = base64Encode(imageBytes);

        // Set request headers
        Map<String, String> headers = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $jwtToken',
        };

        // Send PATCH request with JSON payload
        Uri url = Uri.parse('http://10.0.2.2:4000/api/v1/user/profile-image');
        http.Response response = await http.patch(
          url,
          headers: headers,
          body: jsonEncode({'image': base64Image}),
        );

        if (response.statusCode == 200) {
          final imageUrl = jsonDecode(response.body)['imageUrl'];
          setState(() {
            _imageFile = imageFile;
          });
          print('Image uploaded successfully');
          // Optionally, you can update UI or do other tasks upon successful upload
        } else {
          print('Failed to upload image: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Failed to upload image: $e');
      }
    }
  }

  Future<void> _getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      if (imageFile.existsSync()) {
        // 파일이 존재하는지 확인
        await _uploadImage(imageFile);
        setState(() {
          _imageFile = imageFile; // 변경된 이미지를 상태에 저장
        });
      } else {
        print('파일이 존재하지 않습니다.');
      }
    } else {
      print('이미지를 선택하지 않았습니다.');
    }
  }
}

class _JoinMembership extends StatelessWidget {
  const _JoinMembership({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
        );
      },
      child: Text('회원가입'),
    );
  }
}
