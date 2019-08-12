import 'package:dio/dio.dart';

dynamic getDailyContent() {
  return Dio().post("https://api.hibai.cn/api/index/index",
      data: {"TransCode": "030111", "OpenId": "123456789"});
}

dynamic getPoetryContent(token) {
  return Dio().get("https://v2.jinrishici.com/sentence",
      queryParameters: {"X-User-Token": token});
}

Future<Response<dynamic>> getPoetryTokenFromWeb() {
  return Dio().get("https://v2.jinrishici.com/token");
}
