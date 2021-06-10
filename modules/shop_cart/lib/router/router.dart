import 'package:flutter/material.dart';
import 'package:shop_cart/pages/address/add_address.dart';
import 'package:shop_cart/pages/address/address_list.dart';
import 'package:shop_cart/pages/address/edit_address.dart';
import 'package:shop_cart/pages/pay/choose_pay.dart';
import 'package:shop_cart/pages/settlement.dart';
import 'package:shop_cart/pages/shopping_cart.dart';

class ShoppingCartRouteGenerator {
  //配置路由
  static final routes = {
    "/shoppingCart/cart": (context, {arguments}) => ShoppingCartPage(),
    "/shoppingCart/settlement": (context, {arguments}) => SettlementPage(),
    "/address/addAddress": (context, {arguments}) => AddAddressPage(),
    "/address/addressList": (context, {arguments}) => AddressListPage(),
    "/address/editAddress": (context, {arguments}) =>
        EditAddressPage(arguments: arguments),
    "/pay/choosePay": (context, {arguments}) => ChoosePayPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? name = settings.name;
    final Function pageContentBuilder = routes[name] as Function;
    if (pageContentBuilder != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      return _errorPage('找不到页面');
    }
  }

  static Route _errorPage(msg) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
          appBar: AppBar(title: Text('未知页面')), body: Center(child: Text(msg)));
    });
  }
}
