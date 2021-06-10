import 'package:common/net/http_request.dart';

class UserRequest {
  ///发送短信验证码
  static Future<Map> sendCode(String phone) async {
    // 1.构建URL
    final requestUrl = "api/sendCode";
    // 2.发送网络请求获取结果
    final data =
        await http.request(requestUrl, method: "post", data: {"tel": phone});
    // 3.将Map转成Model
    return data;
  }

  ///验证验证码
  static Future<Map> validateCode(String phone, String code) async {
    // 1.构建URL
    final requestUrl = "api/validateCode";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl,
        method: "post", data: {"tel": phone, "code": code});
    // 3.将Map转成Model
    return data;
  }

  //15299991234
  ///完成注册
  static Future<Map> register(
      String? phone, String? code, String? password) async {
    // 1.构建URL
    final requestUrl = "api/register";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl,
        method: "post",
        data: {"tel": phone, "password": password, "code": code});
    // 3.将Map转成Model
    return data;
  }

  ///登录
  static Future<Map> login(String? username, String? password) async {
    // 1.构建URL
    final requestUrl = "api/doLogin";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl,
        method: "post", data: {"username": username, "password": password});
    // 3.将Map转成Model
    return data;
  }
}
