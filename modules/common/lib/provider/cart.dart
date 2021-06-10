import 'dart:convert';
import 'dart:math';

import 'package:common/utils/cart_util.dart';
import 'package:common/utils/shared_preferences_util.dart';
import 'package:flutter/material.dart';

/// @date on 2021/6/1 14:30
/// @author jack
/// @filename cart.dart
/// @description 购物车状态管理

class Cart with ChangeNotifier {
  List _cartList = [];
  bool cartGoodsAllChecked = false;
  List get cartList => _cartList;
  int allCount = 0;
  double allPrice = 0;

  Cart() {
    initData();
  }

  void initData() {
    CartUtil.getCartData().then((value) {
      allCount = 0;
      allPrice = 0;
      _cartList = value;
      _cartList.forEach((element) {
        allCount += int.parse(element['count'].toString());
        if (element['checked']) {
          allPrice = allPrice +
              (double.parse(element['price'].toString()) *
                  int.parse(element['count'].toString()));
        }
      });
      notifyListeners();
    });
    SharedPreferenceUtil.getBool("cartGoodsAllChecked").then((value) {
      cartGoodsAllChecked = value!;
      notifyListeners();
    });
  }

  void updateData() {
    CartUtil.getCartData().then((value) {
      allCount = 0;
      allPrice = 0;
      _cartList = value;
      _cartList.forEach((element) {
        allCount += int.parse(element['count'].toString());
        if (element['checked']) {
          allPrice = allPrice +
              (double.parse(element['price'].toString()) *
                  int.parse(element['count'].toString()));
        }
      });
      notifyListeners();
    });

    SharedPreferenceUtil.getBool("cartGoodsAllChecked").then((value) {
      cartGoodsAllChecked = value!;
      notifyListeners();
    });
  }

  void removeItem() {
    _cartList.removeWhere((element) => element['checked']);
    SharedPreferenceUtil.putString("cartGoodsList", json.encode(_cartList));
    notifyListeners();
  }

  void removeItemOne(String id, String? attr) {
    _cartList.removeWhere(
        (element) => element['_id'] == id && element['selectedAttr'] == attr);
    SharedPreferenceUtil.putString("cartGoodsList", json.encode(_cartList));
    notifyListeners();
  }
}
