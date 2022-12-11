import 'package:chat_robot_with_danmu/utils/dio_http_util.dart';
import 'package:dio/dio.dart';

class BiliBili {
  //TODO：使用websocket
  // ///获取RoomID
  // Future<String?> _getRelRoomId(String id) async {
  //   Response res = await DioHttpUtil()
  //       .get("https://api.live.bilibili.com/room/v1/Room/room_init?id=$id");
  //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>${res.data['data']['room_id']}");
  //   if (res.data['code'] == 0) {
  //     return res.data['data']['room_id'].toString();
  //   } else {
  //     return null;
  //   }
  // }
  //
  // ///获取RoomID
  // Future<String?> _getWebSocketUrl(String roomId) async {
  //   String? relIRoomId = await _getRelRoomId(roomId);
  //   if (relIRoomId != null) {
  //     Response res = await DioHttpUtil().get(
  //         "https://api.live.bilibili.com/room/v1/Danmu/getConf?room_id=$relIRoomId");
  //     print(">>>>>>>>>>>>>>>>>>>>>>>>>>${res.data['data']['host']}");
  //     if (res.data['code'] == 0) {
  //       return res.data['data']['host'];
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }
  //
  // initBiliBili(String roomId) async {
  //   String? socketUrl = await _getWebSocketUrl(roomId);
  //   if (socketUrl != null) {
  //     var channel =
  //         IOWebSocketChannel.connect(Uri.parse("wss://$socketUrl/sub"));
  //     channel.stream.listen((message) {
  //       print(">>>>>>>>>>>>>>>>>>>>>>>>$message");
  //       channel.sink.add({
  //         "clientver": "1.6.3",
  //         "platform": "web",
  //         "protover": 2,
  //         "roomid": 23058,
  //         "uid": 0,
  //         "type": 2
  //       });
  //       channel.sink.close(status.goingAway);
  //     });
  //   } else {
  //     //TODO:提示弹幕拉取
  //   }
  // }
  ///Http方式获取
  Future<DanMu?> initBiliBili(String roomId) async {
    Response res = await DioHttpUtil()
        .get("https://api.live.bilibili.com/ajax/msg?roomid=$roomId");
    // print(">>>>>>>>>>>>>>>>>>>>>>>>>>${res.data}");
    if (res.data['code'] == 0) {
      res.data['data']['room'];
      return DanMu(
          text: res.data['data']['room'][res.data['data']['room'].length - 1]
              ['text'],
          nickname: res.data['data']['room']
              [res.data['data']['room'].length - 1]['nickname'],
          timeline: res.data['data']['room']
              [res.data['data']['room'].length - 1]['timeline']);
    } else {
      return null;
    }
  }
}

class DanMu {
  String text;
  String nickname;
  String? uid;
  String timeline;
  int? isadmin;
  int? vip;
  int? svip;
  DanMu(
      {required this.text,
      this.isadmin,
      required this.nickname,
      this.svip,
      required this.timeline,
      this.uid,
      this.vip});
}
