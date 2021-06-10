import 'package:category/pages/goods_detail.dart';
import 'package:category/pages/goods_list.dart';
import 'package:category/pages/goods_search.dart';
import 'package:flutter/material.dart';

class CategoryRouteGenerator {
  //配置路由
  static final routes = {
    "/category/goodsList": (context, {arguments}) =>
        GoodsListPage(arguments: arguments),
    "/category/search": (context, {arguments}) => GoodsSearchPage(),
    "/category/goodsDetail": (context, {arguments}) =>
        GoodsDetailPage(arguments: arguments)
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
