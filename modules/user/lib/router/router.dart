import 'package:flutter/material.dart';
import 'package:user/pages/login.dart';
import 'package:user/pages/register_first.dart';
import 'package:user/pages/register_second.dart';
import 'package:user/pages/register_third.dart';

/// @date on 2021/6/3 16:56
/// @author jack
/// @filename router.dart
/// @description 用户路由配置

class UserRouteGenerator {
  //配置路由
  static final routes = {
    "/user/login": (context, {arguments}) => LoginPage(),
    "/user/registerFirst": (context, {arguments}) => RegisterFirstPage(),
    "/user/registerSecond": (context, {arguments}) =>
        RegisterSecondPage(arguments: arguments),
    "/user/registerThird": (context, {arguments}) =>
        RegisterThirdPage(arguments: arguments)
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
