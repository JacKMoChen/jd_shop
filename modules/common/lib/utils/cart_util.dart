import 'dart:convert';

import 'package:common/model/goods_detail.dart';
import 'package:common/constants/config.dart';
import 'package:common/utils/shared_preferences_util.dart';
import 'package:common/utils/string_util.dart';

/// @date on 2021/6/2 14:26
/// @author jack
/// @filename cart_util.dart
/// @description 购物车工具类

class CartUtil {
  ///添加商品到购物车
  static addToCart(GoodsDetail goodsDetail) async {
    var data = convertToCart(goodsDetail);

    var jsonStr = await SharedPreferenceUtil.getString("cartGoodsList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List cartDataList = json.decode(jsonStr!);
      bool hasData = cartDataList.any((v) {
        return v['_id'] == data['_id'] && v['selectAttr'] == data['selectAttr'];
      });

      if (hasData) {
        cartDataList.forEach((v) {
          if (v['_id'] == data['_id'] &&
              v['selectAttr'] == data['selectAttr']) {
            v['count'] = v['count'] + goodsDetail.selectCount;
          }
        });
        SharedPreferenceUtil.putString(
            "cartGoodsList", json.encode(cartDataList));
      } else {
        cartDataList.add(data);
        SharedPreferenceUtil.putString(
            "cartGoodsList", json.encode(cartDataList));
      }
    } else {
      List temp = [];
      temp.add(data);
      SharedPreferenceUtil.putString("cartGoodsList", json.encode(temp));
    }
  }

  ///购物车数据处理
  static convertToCart(GoodsDetail goodsDetail) {
    final Map data = Map<String, dynamic>();
    data['_id'] = goodsDetail.id;
    data['title'] = goodsDetail.title;
    data['price'] = goodsDetail.price;
    data['selectedAttr'] = goodsDetail.selectAttr;
    data['count'] = goodsDetail.selectCount;
    data['pic'] =
        "${HttpConfig.BASEURL + goodsDetail.pic!.replaceAll("\\", "/")}";
    data['checked'] = true;

    return data;
  }

  static Future<List> getCartData() async {
    var jsonStr = await SharedPreferenceUtil.getString("cartGoodsList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List searchDataList = json.decode(jsonStr!);
      return searchDataList;
    } else {
      return [];
    }
  }

  static Future<List> getSettlementData() async {
    var jsonStr = await SharedPreferenceUtil.getString("cartGoodsList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List dataList = json.decode(jsonStr!);
      dataList = dataList.where((element) => element['checked']).toList();
      return dataList;
    } else {
      return [];
    }
  }

  static clear(String key) {
    SharedPreferenceUtil.remove(key);
  }

  static remove(String id, String attr) async {
    var jsonStr = await SharedPreferenceUtil.getString("cartGoodsList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List cartDataList = json.decode(jsonStr!);
      cartDataList.removeWhere((v) {
        return v['_id'] == id && v['selectAttr'] == attr;
      });
      SharedPreferenceUtil.putString(
          "cartGoodsList", json.encode(cartDataList));
    }
  }

  static addCount(String id, String attr) async {
    var jsonStr = await SharedPreferenceUtil.getString("cartGoodsList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List cartDataList = json.decode(jsonStr!);
      cartDataList.any((v) {
        if (v['_id'] == id && v['selectAttr'] == attr) {
          v['count'] = v['count'] + 1;
          return true;
        }
        return false;
      });
      SharedPreferenceUtil.putString(
          "cartGoodsList", json.encode(cartDataList));
    }
  }

  static reduceCount(String id, String attr) async {
    var jsonStr = await SharedPreferenceUtil.getString("cartGoodsList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List cartDataList = json.decode(jsonStr!);
      cartDataList.any((v) {
        if (v['_id'] == id && v['selectAttr'] == attr) {
          v['count'] = v['count'] - 1;
          return true;
        }
        return false;
      });
      SharedPreferenceUtil.putString(
          "cartGoodsList", json.encode(cartDataList));
    }
  }

  static updateCheckedState(String id, String attr, bool checked) async {
    var jsonStr = await SharedPreferenceUtil.getString("cartGoodsList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List cartDataList = json.decode(jsonStr!);
      cartDataList.any((v) {
        if (v['_id'] == id && v['selectAttr'] == attr) {
          v['checked'] = checked;
          return true;
        }
        return false;
      });
      SharedPreferenceUtil.putString(
          "cartGoodsList", json.encode(cartDataList));
    }
  }

  static updateAllCheckedState(bool checked) async {
    SharedPreferenceUtil.putBool("cartGoodsAllChecked", checked);

    var jsonStr = await SharedPreferenceUtil.getString("cartGoodsList");
    if (StringUtil.isNotEmpty(jsonStr)) {
      List cartDataList = json.decode(jsonStr!);
      cartDataList.any((v) {
        v['checked'] = checked;
        return false;
      });
      SharedPreferenceUtil.putString(
          "cartGoodsList", json.encode(cartDataList));
    }
  }
}
