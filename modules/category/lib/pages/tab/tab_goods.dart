import 'dart:async';
import 'package:common/model/goods_detail.dart';
import 'package:common/utils/string_util.dart';
import 'package:common/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/constants/config.dart';
import 'package:common/event/event_cart.dart';
import 'package:common/utils/cart_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @date on 2021/5/31 10:42
/// @author jack
/// @filename tab_goods.dart
/// @description 商品详情->tab商品

class TabGoodsPage extends StatefulWidget {
  GoodsDetail goodsDetail;
  TabGoodsPage(this.goodsDetail, {Key? key}) : super(key: key);

  @override
  _TabGoodsPageState createState() => _TabGoodsPageState();
}

class _TabGoodsPageState extends State<TabGoodsPage> {
  late GoodsDetail goodsDetail;
  List attrs = [];
  StreamSubscription? cartEventSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goodsDetail = widget.goodsDetail;
    attrs.clear();
    goodsDetail.attr!.forEach((element) {
      element.attrList!.clear();
      for (var i = 0; i < element.list!.length; i++) {
        if (i == 0) {
          attrs.add(element.list![i]);
        }
        element.attrList!
            .add({"title": element.list![i], "selected": i == 0, "index": i});
      }
    });
    goodsDetail.selectAttr = attrs.join(",");
    cartEventSubscription = eventBus.on<CartEvent>().listen((event) {
      //显示属性面板
      if (mounted) {
        _showModalSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      child: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              "${HttpConfig.BASEURL + goodsDetail.pic!.replaceAll("\\", "/")}",
              fit: BoxFit.fill,
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                "${StringUtil.isNotEmpty(goodsDetail.title) ? goodsDetail.title : ''}",
                style: TextStyle(color: Colors.black87, fontSize: 14.sp),
              )),
          Container(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                "${StringUtil.isNotEmpty(goodsDetail.subTitle) ? goodsDetail.subTitle : ''}",
                style: TextStyle(color: Colors.black54, fontSize: 12.sp),
              )),
          Container(
            padding: EdgeInsets.only(top: 10.h),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text("特价 ", style: TextStyle(fontSize: 16.sp)),
                      Text(
                        "￥${goodsDetail.price}",
                        style: TextStyle(color: Colors.red, fontSize: 16.sp),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("原价 ", style: TextStyle(fontSize: 14.sp)),
                      Text(
                        "${goodsDetail.oldPrice}",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14.sp,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (goodsDetail.attr != null && goodsDetail.attr!.length > 0) {
                _showModalSheet();
              }
            },
            child: Container(
                margin: EdgeInsets.only(top: 10.h),
                height: 30.h,
                child:
                    (goodsDetail.attr != null && goodsDetail.attr!.length > 0)
                        ? Row(
                            children: [
                              Text(
                                "已选:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${attrs.join(",")}")
                            ],
                          )
                        : Text("")),
          ),
          Divider(),
          Container(
              height: 30.h,
              child: Row(
                children: [
                  Text(
                    "运费:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("免运费")
                ],
              )),
          Divider()
        ],
      ),
    );
  }

  ///属性选择
  _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setSheetState) {
            return Container(
              padding: EdgeInsets.only(top: 10.h, right: 20.w),
              height: 300.h,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: this.goodsDetail.attr!.map((item) {
                            return Wrap(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  child: Text("${item.cate}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Wrap(
                                  children: item.attrList!.map((e) {
                                    return Container(
                                      margin: EdgeInsets.only(left: 5.w),
                                      child: ChoiceChip(
                                        selected: e['selected'],
                                        selectedColor: Colors.red,
                                        labelStyle: TextStyle(
                                            color: e['selected']
                                                ? Colors.white
                                                : Colors.black),
                                        onSelected: (v) {
                                          if (v) {
                                            item.selectIndex = e['index'];
                                            item.attrList!.forEach((element) {
                                              if (item.selectIndex ==
                                                  element['index']) {
                                                element['selected'] = true;
                                                attrs.add(element['title']);
                                              } else {
                                                attrs.remove(element['title']);
                                                element['selected'] = false;
                                              }
                                            });
                                          } else {
                                            e['selected'] = false;
                                            attrs.remove(e['title']);
                                          }
                                          goodsDetail.selectAttr =
                                              attrs.join(",");
                                          setSheetState(() {});
                                          setState(() {});
                                        },
                                        label: Text("${e['title']}"),
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            );
                          }).toList()),
                      Divider(),
                      buildGoodsNum(setSheetState)
                    ],
                  ),
                  Positioned(
                      bottom: 5.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 25.w),
                            width: 150.w,
                            child: TextButton(
                              onPressed: () async {
                                print(goodsDetail.selectCount);
                                await CartUtil.addToCart(goodsDetail);
                                Provider.of<Cart>(context, listen: false)
                                    .updateData();
                                Navigator.of(context).pop();
                                Fluttertoast.showToast(
                                  msg: "已加入购物车",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );
                                goodsDetail.selectCount = 1;
                              },
                              child: Text("加入购物车"),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(234, 1, 0, 0.9)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  overlayColor:
                                      MaterialStateProperty.all(Colors.black12),
                                  alignment: Alignment.center),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10.w),
                            width: 150.w,
                            child: TextButton(
                                onPressed: () {},
                                child: Text("立即购买"),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromRGBO(255, 165, 0, 0.9)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.black12),
                                    alignment: Alignment.center)),
                          )
                        ],
                      ))
                ],
              ),
            );
          });
        });
  }

  ///数量组件
  Widget buildGoodsNum(setSheetState) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20.w,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10.w),
          child: Text("数量:"),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.w),
          width: 67.w,
          height: 20.w,
          decoration: BoxDecoration(
              border: Border.all(width: 1.w, color: Colors.black12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20.w,
                alignment: Alignment.center,
                child: IconButton(
                    onPressed: () {
                      setSheetState(() {
                        if (goodsDetail.selectCount! > 1) {
                          goodsDetail.selectCount =
                              goodsDetail.selectCount! - 1;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.remove,
                      size: 10.h,
                    )),
              ),
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 1.w, color: Colors.black12),
                          right:
                              BorderSide(width: 1.w, color: Colors.black12))),
                  width: 25.w,
                  height: 20.w,
                  child: Text(
                    "${goodsDetail.selectCount}",
                    textAlign: TextAlign.center,
                  )),
              Container(
                width: 20.w,
                child: IconButton(
                    onPressed: () {
                      setSheetState(() {
                        goodsDetail.selectCount = goodsDetail.selectCount! + 1;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      size: 10.h,
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    cartEventSubscription!.cancel();
    super.dispose();
  }
}
