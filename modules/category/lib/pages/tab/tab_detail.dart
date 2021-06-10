import 'package:common/model/goods_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @date on 2021/5/31 10:41
/// @author jack
/// @filename detail.dart
/// @description 商品详情->tab详情

class TabDetailPage extends StatefulWidget {
  GoodsDetail goodsDetail;
  TabDetailPage(this.goodsDetail, {Key? key}) : super(key: key);

  @override
  _TabDetailPageState createState() => _TabDetailPageState();
}

class _TabDetailPageState extends State<TabDetailPage> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [Html(data: widget.goodsDetail.content)],
    );
  }
}
