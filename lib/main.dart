import 'package:chat_robot_with_danmu/pages/chat.dart';
import 'package:chat_robot_with_danmu/utils/dio_http_util.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DioHttpUtil().init();
    // TTSUtil.initTTS();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGPT 弹幕聊天工具',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Chat(),
    );
  }
}
