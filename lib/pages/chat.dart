import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/platform/bilibili.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  DanMu? danMu = DanMu(timeline: '', text: '', nickname: '');
  final ScrollController _controller = ScrollController();
  List<Widget> msgList = [];
  AudioPlayer audioPlayer = AudioPlayer();
  String temp = "";
  getBiliBili() async {
    for (int i = 0; i < 1;) {
      sleep(const Duration(seconds: 1));
      danMu = await BiliBili().initBiliBili('24150856');
      if (danMu?.text != temp) {
        temp = danMu?.text ?? "";
        // audioPlayer.setSourceUrl(
        //     "https://tts.youdao.com/fanyivoice?word=$temp&le=zh&keyfrom=speaker-target");
        // audioPlayer.play(source);
        // TTSUtil.speak(temp);
        if (kDebugMode) {
          print("${danMu?.timeline}\n${danMu?.nickname}:${danMu?.text}");
        }
        msgList.add(Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    danMu!.nickname.substring(0, 1),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        danMu!.nickname,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Bubble(
                          padding: const BubbleEdges.all(10),
                          radius: const Radius.circular(20.0),
                          alignment: Alignment.bottomLeft,
                          color: Colors.indigoAccent,
                          nip: BubbleNip.leftCenter,
                          child: Text(
                            danMu?.text ?? '',
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            danMu!.timeline,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 8),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
        _controller.jumpTo(_controller.position.maxScrollExtent);
        setState(() {});
        await Future.delayed(const Duration(seconds: 1), () {
          msgList.add(Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Bubble(
                        padding: const BubbleEdges.all(10),
                        radius: const Radius.circular(20.0),
                        alignment: Alignment.topRight,
                        color: Colors.blueAccent,
                        nip: BubbleNip.rightCenter,
                        child: Text(
                          '${danMu?.text}',
                          style: const TextStyle(color: Colors.white),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.bottomLeft,
                      //   margin: const EdgeInsets.only(top: 8, right: 50),
                      //   child: Text(
                      //     "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                      //     style: const TextStyle(color: Colors.grey, fontSize: 8),
                      //   ),
                      // )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircleAvatar(
                    backgroundColor: Color.fromRGBO(85, 143, 183, 1.0),
                    backgroundImage: NetworkImage(
                        "https://img.zcool.cn/community/01f0865d45230ba8012187f485a17b.jpg@1280w_1l_2o_100sh.jpg"),
                  ),
                )
              ],
            ),
          ));
        });
        _controller.jumpTo(_controller.position.maxScrollExtent);
        // ChatRobot.sendChatMsg(temp.trim());
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBiliBili();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _controller,
        itemCount: msgList.length,
        itemBuilder: (context, index) {
          return msgList[index];
        },
      ),
    );
  }
}
