import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mojadel2/mypage/profile/modifyprofile.dart';
import 'package:mojadel2/mypage/signup/signup.dart';
import 'package:mojadel2/mypage/signup/tabbar_using_controller.dart';
import 'package:mojadel2/mypage/signup/tabmenu_tabbar.dart';
import 'package:mojadel2/mypage/signup/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login/loginpage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> transactionTypes = ['중고거래', '공동구매'];

class mypagesite extends StatefulWidget {
  const mypagesite({Key? key}) : super(key: key);

  @override
  State<mypagesite> createState() => _mypagesiteState();
}

class _mypagesiteState extends State<mypagesite> with SingleTickerProviderStateMixin {
  String? _nickname;
  File? _imageFile;
  ImagePicker picker = ImagePicker();

  late TabController _tabController;
  String dropDownValue = transactionTypes.first;

  @override
  void initState() {
    super.initState();
    _loadNickname(); // initState에서 호출
    _tabController = TabController(length: TABS.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF8F8FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _UserInformation(),
            SizedBox(height: 10.0),
            // _JoinMembership(),
            // TextButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => LogInPage()),
            //     ).then(
            //           (jwtToken) {
            //         if (jwtToken != null) {
            //           // 로그인 성공 후 사용자의 닉네임을 가져옴
            //           _getNickname(jwtToken).then((nickname) {
            //             if (nickname != null) {
            //               // 닉네임을 성공적으로 가져왔을 때 상태 업데이트
            //               setState(() {
            //                 _nickname = nickname;
            //               });
            //             }
            //           });
            //         }
            //       },
            //     );
            //   },
            //   child: Text('로그인'),
            // ),
            // TextButton(
            //   onPressed: () async {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text('로그아웃 완료'),
            //       ),
            //     );
            //     await _logout();
            //   },
            //   child: Text('로그아웃'),
            // ),
            // TextButton(
            //   onPressed: () {
            //     _getImage(ImageSource.gallery);
            //   },
            //   child: Text('프로필 사진 변경'),
            // ),
            // ElevatedButton(
            //   onPressed: (){
            //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => TabMenuTabbar()));
            //   },
            //   child: Text('Tabbar Test'),
            // ),
            TabMenuTabbar(),
            TabBarUsingController(),
          ],
        ),
      ),
    );
  }

  Widget _statisticOne(String title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: TextStyle(fontSize: 12.0, color: Colors.black54)),
        SizedBox(width: 5.0),
        Text(value.toString(),
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            )),
      ],
    );
  }

  Widget _UserInformation() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                    // 태두리 선의 색상 설정
                    width: 0.5, // 태두리 선의 두께 설정
                  ),
                ),
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white10,
                    backgroundImage:
                        _imageFile != null ? FileImage(_imageFile!) : null),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _nickname ?? '비회원',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(child: _statisticOne('YOMO', 14)),
                        Expanded(child: _statisticOne('Followers', 20)),
                        Expanded(child: _statisticOne('Following', 25)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(240, 20.0),
                        side: BorderSide(color: Color(0xFFDBDBDB)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) => modifiyProfile()),
                        );
                      },
                      child: Text(
                        '프로필 편집',
                        style: TextStyle(color: Colors.black, fontSize: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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


