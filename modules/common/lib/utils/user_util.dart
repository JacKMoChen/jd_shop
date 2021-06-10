import 'dart:convert';

import 'package:common/utils/shared_preferences_util.dart';
import 'package:common/utils/string_util.dart';

class UserHelper {
  static List userinfo = [];

  static Future<List> getUserInfo() async {
    var jsonStr = await SharedPreferenceUtil.getString("userinfo");
    if (StringUtil.isNotEmpty(jsonStr)) {
      userinfo = json.decode(jsonStr!);
    } else {
      userinfo = [];
    }
    return userinfo;
  }

  static bool isLogin() {
    if (userinfo.length > 0 && userinfo[0] != null) {
      return true;
    }
    return false;
  }

  static void logOut() {
    SharedPreferenceUtil.remove("userinfo");
  }
}
