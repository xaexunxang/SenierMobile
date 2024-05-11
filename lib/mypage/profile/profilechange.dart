// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mojadel2/colors/colors.dart';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';
// import '../mypage.dart';
//
// class profilechange extends StatefulWidget {
//   const profilechange({super.key});
//
//   @override
//   State<profilechange> createState() => _profilechangeState();
// }
//
// class _profilechangeState extends State<profilechange> {
//
//   XFile? _image;
//   ImagePicker picker = ImagePicker();
//   final Dio _dio = Dio();
//
//   Future<void> uploadImage() async {
//     if (_image == null) {
//       print('이미지를 선택해주세요.');
//       return;
//     }
//
//     try {
//       List<int> imageBytes = await _image!.readAsBytes();
//       String base64Image = base64Encode(imageBytes);
//
//       // 사용자의 인증 토큰
//       String authToken = ''; // 여기에 사용자의 인증 토큰을 할당하세요.
//
//       // 요청 헤더에 인증 토큰을 추가하여 Dio 인스턴스 생성
//       Dio dio = Dio(BaseOptions(
//         headers: {
//           HttpHeaders.authorizationHeader: 'Bearer $authToken',
//           'Content-Type': 'application/json',
//         },
//       ));
//
//       // 서버에 이미지 업로드 요청
//       Response response = await dio.patch(
//         'http://10.0.2.2:4000/api/v1/user/profile-image',
//         data: {'image': base64Image},
//       );
//
//       if (response.statusCode == 200) {
//         print('이미지 업로드 성공');
//         Navigator.pushReplacementNamed(context, '/mypagesite');
//       } else {
//         print('이미지 업로드 실패: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('이미지 업로드 중 오류 발생: $e');
//     }
//   }
//
//
//   Future getImage(ImageSource imageSource) async {
//     final XFile? pickedFile = await picker.pickImage(source: imageSource);
//     if (pickedFile != null) {
//       setState(() {
//         _image = pickedFile;
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('프로필 변경 화면'),
//         backgroundColor: AppColors.mintgreen,
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
//           child:  Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.black, // 태두리 선의 색상 설정
//                 width: 1.0, // 태두리 선의 두께 설정
//               ),
//             ),
//             child: CircleAvatar(
//               radius: 50,
//               backgroundColor: Colors.white10,
//               backgroundImage: _image != null
//                   ? FileImage(File(_image!.path)) // XFile을 File로 변환하여 사용
//                   : null,
//             ),
//           ),
//           ),
//           TextButton(onPressed: (){
//             getImage(ImageSource.gallery);
//           },
//               child: Text('사진 선택')),
//           TextButton(onPressed: (){
//             uploadImage();
//           },
//               child: Text('등록하기')),
//         ],
//       ),
//     );
//   }
// }
