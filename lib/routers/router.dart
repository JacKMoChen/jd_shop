import 'package:category/router/router.dart';
import 'package:flutter_jdshop/pages/main.dart';
import 'package:shop_cart/router/router.dart';
import 'package:flutter/material.dart';
import 'package:user/router/router.dart';
import 'package:profile/router/router.dart';

class RouteGenerator {
  //配置路由
  static final routes = {
    ...CategoryRouteGenerator.routes,
    ...ShoppingCartRouteGenerator.routes,
    ...UserRouteGenerator.routes,
    ...ProfileRouteGenerator.routes,
    "/main": (context, {arguments}) => MainPage()
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
