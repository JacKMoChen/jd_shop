import 'package:common/model/goods_detail.dart';
import 'package:flutter/material.dart';

/// @date on 2021/5/31 10:44
/// @author jack
/// @filename tab_evaluation.dart
/// @description 商品详情->tab评价

class TabEvaluationPage extends StatefulWidget {
  GoodsDetail goodsDetail;
  TabEvaluationPage(this.goodsDetail, {Key? key}) : super(key: key);

  @override
  _TabEvaluationPageState createState() => _TabEvaluationPageState();
}

class _TabEvaluationPageState extends State<TabEvaluationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return ListTile(
            title: Text("$index评价"),
          );
        },
        itemCount: 30,
      ),
    );
  }
}
