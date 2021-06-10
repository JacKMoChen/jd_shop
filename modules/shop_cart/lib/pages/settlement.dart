import 'dart:async';
import 'dart:convert';
import 'package:common/utils/cart_util.dart';
import 'package:common/utils/user_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:common/provider/cart.dart';
import 'package:shop_cart/api/address_request.dart';
import 'package:shop_cart/api/order_request.dart';
import 'package:shop_cart/model/address.dart';
import 'package:common/event/event_address.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @date on 2021/6/7 10:00
/// @author jack
/// @filename settlement.dart
/// @description 结算页面

class SettlementPage extends StatefulWidget {
  SettlementPage({Key? key}) : super(key: key);

  @override
  _SettlementPageState createState() => _SettlementPageState();
}

class _SettlementPageState extends State<SettlementPage> {
  List? goodsList;
  int _discount = 5;
  int _shipping = 0;
  Address? _address;
  StreamSubscription? eventSubscription;
  @override
  void initState() {
    getDefaultAddress();
    CartUtil.getSettlementData().then((value) {
      setState(() {
        goodsList = value;
      });
    });

    eventSubscription = eventBus.on<AddressEvent>().listen((event) {
      //显示属性面板
      if (mounted && event.event == "event_change_default_address") {
        getDefaultAddress();
      }
    });
    super.initState();
  }

  void getDefaultAddress() {
    var params = {
      "uid": "${UserHelper.userinfo[0]['_id']}",
      "salt": "${UserHelper.userinfo[0]['salt']}"
    };
    AddressRequest.getDefaultAddress(params).then((value) {
      setState(() {
        _address = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("结算"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _address == null
                        ? ListTile(
                            leading: Icon(Icons.add_location),
                            title: Center(child: Text("请添加收货地址")),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/address/addAddress");
                            },
                          )
                        : ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${_address!.name} ${_address!.phone}"),
                                Text(
                                  "${_address!.address}",
                                  style: TextStyle(color: Colors.black54),
                                )
                              ],
                            ),
                            trailing: Icon(Icons.navigate_next),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, "/address/addressList");
                            })
                  ],
                ),
              ),
              buildGoodsList(),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child:
                          Text("商品总金额:￥${Provider.of<Cart>(context).allPrice}"),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Text("立减:￥$_discount"),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(8.0.w),
                      child: Text("运费:￥$_shipping"),
                    ),
                  ],
                ),
              )
            ],
          ),
          buildBottom(context)
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return Positioned(
        bottom: 0,
        width: 1.sw,
        height: 50.h,
        child: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          decoration: BoxDecoration(
              border:
                  Border(top: BorderSide(color: Colors.black12, width: 1.h))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "总价:￥${Provider.of<Cart>(context).allPrice - _discount + _shipping}",
                style: TextStyle(color: Colors.red),
              ),
              TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(60.w, 25.h)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                ),
                onPressed: () {
                  if (_address == null) {
                    Fluttertoast.showToast(
                      msg: "请选择收货地址",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                    return;
                  }
                  Provider.of<Cart>(context, listen: false).removeItem();
                  Provider.of<Cart>(context, listen: false).updateData();
                  doOrder();
                },
                child: Text(
                  "立即下单",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ));
  }

  void doOrder() {
    var params = {
      "uid": "${UserHelper.userinfo[0]['_id']}",
      "address": _address!.address,
      "phone": _address!.phone,
      "name": _address!.name,
      "all_price": (Provider.of<Cart>(context, listen: false).allPrice -
              _discount +
              _shipping)
          .toStringAsFixed(1),
      "products": json.encode(goodsList),
      "salt": "${UserHelper.userinfo[0]['salt']}"
    };
    OrderRequest.doOrder(params).then((result) {
      if (result['success']) {
        Navigator.pushNamed(context, "/pay/choosePay");
      } else {
        Fluttertoast.showToast(
          msg: result['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }

  Widget buildGoodsList() {
    return goodsList == null
        ? Text("")
        : Container(
            padding: EdgeInsets.only(left: 10.w, right: 20.w),
            child: Column(
              children: goodsList!.map((item) {
                return Row(
                  children: [
                    Container(
                      width: 80.h,
                      height: 80.h,
                      child: Image.network("${item['pic']}"),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item['title']}",
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            Text("${item['selectedAttr']}",
                                style: TextStyle(color: Colors.black54)),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "￥${item['price']}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("${item['count']}"),
                                )
                              ],
                            )
                          ],
                        ))
                  ],
                );
              }).toList(),
            ),
          );
  }

  @override
  void dispose() {
    eventSubscription!.cancel();
    super.dispose();
  }
}
