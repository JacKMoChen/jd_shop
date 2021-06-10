import 'dart:convert';
import 'dart:async';
import 'package:common/utils/shared_preferences_util.dart';
import 'package:common/utils/string_util.dart';

class SearchUtil {
  static setSearchData(String? keyWords) async {
    if (StringUtil.isEmpty(keyWords)) {
      return;
    }
    var jsonStr = await SharedPreferenceUtil.getString("searchList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List searchDataList = json.decode(jsonStr!);
      bool hasData = searchDataList.any((v) {
        return v == keyWords;
      });
      print(searchDataList);
      if (!hasData) {
        searchDataList.add(keyWords);
        SharedPreferenceUtil.putString(
            "searchList", json.encode(searchDataList));
      }
    } else {
      List temp = [];
      temp.add(keyWords);
      print(temp);
      SharedPreferenceUtil.putString("searchList", json.encode(temp));
    }
  }

  static Future<List> getSearchData() async {
    var jsonStr = await SharedPreferenceUtil.getString("searchList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List searchDataList = json.decode(jsonStr!);
      return searchDataList;
    } else {
      return [];
    }
  }

  static clear(String key) {
    SharedPreferenceUtil.remove(key);
  }

  static remove(String keyWords) async {
    var jsonStr = await SharedPreferenceUtil.getString("searchList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List searchDataList = json.decode(jsonStr!);
      searchDataList.remove(keyWords);
      SharedPreferenceUtil.putString("searchList", json.encode(searchDataList));
    }
  }
}
