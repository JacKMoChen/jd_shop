import 'package:common/utils/user_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile/api/order_request.dart';
import 'package:profile/model/order.dart';

/// @date on 2021/6/9 16:51
/// @author jack
/// @filename order_list.dart
/// @description

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  List<Order> orderList = [];
  @override
  void initState() {
    var params = {
      "uid": "${UserHelper.userinfo[0]['_id']}",
      "salt": "${UserHelper.userinfo[0]['salt']}"
    };
    OrderRequest.getOrderList(params).then((value) {
      setState(() {
        orderList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的订单")),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.h),
            padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
            child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/order/orderDetail",
                          arguments: orderList[index].toJson());
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Container(
                            height: 40.h,
                            child: ListTile(
                              minVerticalPadding: 0,
                              title: Text(
                                "订单编号:${orderList[index].id}",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Divider(),
                          Column(
                            children: orderList[index].orderItem!.map((item) {
                              return Container(
                                margin: EdgeInsets.only(top: 10.h),
                                child: ListTile(
                                  leading: Container(
                                    width: 50.h,
                                    height: 50.h,
                                    child: Image.network("${item.productImg}"),
                                  ),
                                  title: Text("${item.productTitle}"),
                                  trailing: Text("x${item.productCount}"),
                                ),
                              );
                            }).toList(),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                Text("合计:"),
                                Text(
                                  "￥${orderList[index].allPrice}",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                            trailing: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "申请售后",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.black12),
                                    alignment: Alignment.center)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: orderList.length),
          ),
          Positioned(
              top: 0,
              child: Container(
                width: 1.sw,
                color: Colors.white,
                height: 40.h,
                child: Row(
                  children: [
                    Expanded(child: Text("全部", textAlign: TextAlign.center)),
                    Expanded(child: Text("待付款", textAlign: TextAlign.center)),
                    Expanded(child: Text("待发货", textAlign: TextAlign.center)),
                    Expanded(child: Text("待收货", textAlign: TextAlign.center)),
                    Expanded(child: Text("待评价", textAlign: TextAlign.center)),
                    Expanded(child: Text("退款/售后", textAlign: TextAlign.center))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
