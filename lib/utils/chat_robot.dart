import 'dio_http_util.dart';

class ChatRobot {
  ChatRobot._();
  static Future<String> sendChatMsg(String msg,
      {model = "text-davinci-003", temperature = 1, maxTokens = 1024}) async {
    var res = await DioHttpUtil()
        .post("https://api.openai.com/v1/completions", data: {
      "model": model,
      "prompt": msg,
      "temperature": temperature,
      "max_tokens": maxTokens,
    });

    if (res.data["choices"] != null) {
      return res.data["choices"][0]["text"];
    } else {
      return "人家听不懂你在说什么啦！";
    }
  }
}
