import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:profile/model/order.dart';
import 'package:intl/intl.dart';

class OrderDetailPage extends StatefulWidget {
  Map arguments;
  OrderDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Order order;

  @override
  void initState() {
    order = Order.fromJson(widget.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单详情"),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(Icons.location_on_outlined),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${order.name} ${order.phone}"),
                    Text(
                      "${order.address}",
                      style: TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black12,
              thickness: 10.h,
            ),
            buildGoodsList(),
            Container(
              height: 40.h,
              margin: EdgeInsets.only(left: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "总金额:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("￥${order.allPrice}",
                      style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            Divider(
              color: Colors.black12,
              thickness: 10.h,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "订单编号:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " ${order.id}",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "下单日期:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " ${DateFormat('yyyy-MM-dd').format(DateTime.now())}",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "支付方式:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " 支付宝",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "配送方式:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " 顺丰",
                    style: TextStyle(color: Colors.black87),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGoodsList() {
    return order.orderItem == null
        ? Text("")
        : Container(
            padding: EdgeInsets.only(left: 10.w, right: 20.w),
            child: Column(
              children: order.orderItem!.map((item) {
                return Row(
                  children: [
                    Container(
                      width: 80.h,
                      height: 80.h,
                      child: Image.network("${item.productImg}"),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item.productTitle}",
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            Text("${item.selectedAttr}",
                                style: TextStyle(color: Colors.black54)),
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "￥${item.productPrice}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("X${item.productCount}"),
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
}
