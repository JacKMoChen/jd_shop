import 'package:category/api/category_request.dart';
import 'package:common/model/goods_detail.dart';
import 'package:category/pages/tab/tab_detail.dart';
import 'package:category/pages/tab/tab_evaluation.dart';
import 'package:category/pages/tab/tab_goods.dart';
import 'package:common/provider/cart.dart';
import 'package:common/utils/cart_util.dart';
import 'package:common/widgets/loading_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:common/event/event_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:badges/badges.dart';

/// @date on 2021/5/31 10:02
/// @author jack
/// @filename goods_detail.dart
/// @description 商品详情页

class GoodsDetailPage extends StatefulWidget {
  Map arguments;

  GoodsDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  GoodsDetail? _goodsDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryRequest.getGoodsDetail(widget.arguments['id']).then((value) {
      setState(() {
        _goodsDetail = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Container(
              alignment: Alignment.center,
              width: 150.w,
              child: TabBar(
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(child: Text("商品")),
                  Tab(child: Text("详情")),
                  Tab(child: Text("评价"))
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(600.w, 60.h, 10.w, 0),
                      items: [
                        PopupMenuItem(
                            child: Row(
                          children: [Icon(Icons.share), Text("分享")],
                        )),
                        PopupMenuItem(
                            child: Row(
                          children: [Icon(Icons.share), Text("分享")],
                        )),
                        PopupMenuItem(
                            child: Row(
                          children: [Icon(Icons.share), Text("分享")],
                        ))
                      ]);
                },
                icon: Icon(Icons.more_horiz))
          ],
        ),
        body: this._goodsDetail != null
            ? Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 50.h),
                    child: TabBarView(
                      children: [
                        TabGoodsPage(_goodsDetail!),
                        TabDetailPage(_goodsDetail!),
                        TabEvaluationPage(_goodsDetail!)
                      ],
                    ),
                  ),
                  buildBottom()
                ],
              )
            : LoadingDialog(),
      ),
    );
  }

  //底部区域
  Widget buildBottom() {
    return Positioned(
        width: 1.sw,
        height: 50.h,
        bottom: 0,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(top: BorderSide(color: Colors.black38, width: 1.h))),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/shoppingCart/cart');
                },
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  padding: EdgeInsets.all(5.h),
                  child: Column(
                    children: [
                      Badge(
                          showBadge: Provider.of<Cart>(context).allCount > 0,
                          padding: EdgeInsets.all(2),
                          badgeContent: Text(
                            '${Provider.of<Cart>(context).allCount}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 8.sp),
                          ),
                          child: Icon(Icons.shopping_cart)),
                      Text("购物车")
                    ],
                  ),
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () async {
                    if (_goodsDetail!.attr != null &&
                        _goodsDetail!.attr!.length > 0) {
                      eventBus.fire(CartEvent('add_to_cart'));
                    } else {
                      //直接加入购物车
                      await CartUtil.addToCart(_goodsDetail!);
                      Provider.of<Cart>(context, listen: false).updateData();
                      Fluttertoast.showToast(
                        msg: "已加入购物车",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    }
                  },
                  child: Text("加入购物车"),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(145.w, 30.h)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromRGBO(234, 1, 0, 0.9)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      overlayColor: MaterialStateProperty.all(Colors.black12),
                      alignment: Alignment.center),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w),
                child: TextButton(
                    onPressed: () {
                      if (_goodsDetail!.attr != null &&
                          _goodsDetail!.attr!.length > 0) {
                        eventBus.fire(CartEvent('event_buy_now'));
                      } else {
                        //立即购买
                        print("立即购买");
                      }
                    },
                    child: Text("立即购买"),
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(Size(145.w, 30.h)),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(255, 165, 0, 0.9)),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor: MaterialStateProperty.all(Colors.black12),
                        alignment: Alignment.center)),
              )
            ],
          ),
        ));
  }
}
