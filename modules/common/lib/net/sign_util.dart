import 'dart:convert';

import 'package:crypto/crypto.dart';

/// @date on 2021/6/9 10:03
/// @author jack
/// @filename sign_util.dart
/// @description 网络请求签名

class SignUtil {
  static String getSign(Map params) {
    var key = '密钥';
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    /* params['timestamp'] = timestamp.toString();*/
    /// 存储所有key
    List allKeys = params.keys.toList();

    /// key排序,升序排列
    allKeys.sort();
    String sign = '';

    allKeys.forEach((element) {
      sign += "$element${params[element]}";
    });
    String signString = generateMd5(sign);
    return signString;
  }

  static String generateMd5(String data) {
    var digest = md5.convert(utf8.encode(data));
    // 这里其实就是 digest.toString()
    return digest.toString();
  }
}
