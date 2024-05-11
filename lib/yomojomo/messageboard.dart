import 'package:flutter/material.dart';
import 'package:mojadel2/colors/colors.dart';
import 'package:mojadel2/yomojomo/writeboard.dart';

class MessageBoard extends StatefulWidget {
  const MessageBoard({super.key});

  @override
  State<MessageBoard> createState() => _MessageBoardState();
}

class Message {
  final String title;
  final String content;

  Message(this.title, this.content);
}

class _MessageBoardState extends State<MessageBoard> {
  List<Message> _messages = [];
  String userEmail = "example@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('요모조모'),
          backgroundColor: AppColors.mintgreen,
        ),
        body: _messages.isEmpty // 게시글이 없을 경우
            ? Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text('아직 게시글이 없습니다'),
                ),
              )
            : ListView.builder(
                itemCount: _messages.isEmpty ? 0 : (_messages.length * 2 - 1),
                itemBuilder: (context, index) {
                  if (index.isOdd) {
                    return Divider(); // 홀수 인덱스에 Divider 추가
                  }
                  final messageIndex = index ~/ 2;
                  return ListTile(
                    title: Text(_messages[messageIndex].title),
                    subtitle: Text(_messages[messageIndex].content),
                    onTap: () {
                      // 게시글을 클릭하면 자세한 화면으로 이동
                      // Navigator.push(
                      //   context,
                      //   // MaterialPageRoute(
                      //   //   // builder: (context) => DetailScreen(message: _messages[index]),
                      //   // ),
                      // );
                    },
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final message = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WriteBoard()),
            );
            if (message != null) {
              setState(() {
                _messages.add(message);
              });
            }
          },
          backgroundColor: AppColors.mintgreen,
          child: Icon(Icons.mode_edit_outline_sharp),
        ));
  }
}
