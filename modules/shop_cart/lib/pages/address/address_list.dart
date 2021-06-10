import 'dart:async';

import 'package:common/event/event_address.dart';
import 'package:common/utils/user_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_cart/api/address_request.dart';
import 'package:shop_cart/model/address.dart';

/// @date on 2021/6/7 14:29
/// @author jack
/// @filename add_address.dart
/// @description 收货地址列表

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);

  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List<Address> addressList = [];

  StreamSubscription? eventSubscription;

  @override
  void initState() {
    getAddressList();
    eventSubscription = eventBus.on<AddressEvent>().listen((event) {
      //显示属性面板
      if (mounted &&
          (event.event == "event_add_address" ||
              event.event == "event_edit_address")) {
        getAddressList();
      }
    });
    super.initState();
  }

  void getAddressList() {
    var params = {
      "uid": "${UserHelper.userinfo[0]['_id']}",
      "salt": "${UserHelper.userinfo[0]['salt']}"
    };
    AddressRequest.getAddressList(params).then((value) {
      setState(() {
        addressList = value;
      });
    });
  }

  ///修改默认地址
  void changeDefaultAddress(id) {
    var params = {
      "uid": "${UserHelper.userinfo[0]['_id']}",
      "id": id,
      "salt": "${UserHelper.userinfo[0]['salt']}"
    };
    AddressRequest.changeDefaultAddress(params).then((result) {
      Fluttertoast.showToast(
        msg: result['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      if (result['success']) {
        eventBus.fire(AddressEvent('event_change_default_address'));
        Navigator.pop(context);
      }
    });
  }

  ///删除地址
  void deleteAddress(id) {
    var params = {
      "uid": "${UserHelper.userinfo[0]['_id']}",
      "id": id,
      "salt": "${UserHelper.userinfo[0]['salt']}"
    };
    AddressRequest.deleteAddress(params).then((result) {
      Fluttertoast.showToast(
        msg: result['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      if (result['success']) {
        getAddressList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址列表"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [buildListView(), buildBottom(context)],
        ),
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return Positioned(
        bottom: 0,
        width: 1.sw,
        height: 40.h,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              border:
                  Border(top: BorderSide(color: Colors.black12, width: 1.h))),
          child: TextButton.icon(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(1.sw, 40.h)),
              backgroundColor: MaterialStateProperty.all(Colors.red),
              overlayColor: MaterialStateProperty.all(Colors.black12),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/address/addAddress");
            },
            label: Text(
              "增加收货地址",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ));
  }

  Widget buildListView() {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Column(
          children: [
            ListTile(
              onLongPress: () {
                _editItemDialog(addressList[index].id);
              },
              leading: addressList[index].defaultAddress == 1
                  ? Icon(Icons.check, color: Colors.red)
                  : null,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${addressList[index].name} ${addressList[index].phone}"),
                  Text(
                    "${addressList[index].address}",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/address/editAddress",
                      arguments: addressList[index].toJson());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Divider(
              height: 30.h,
            )
          ],
        );
      },
      itemCount: addressList.length,
    );
  }

  @override
  void dispose() {
    eventSubscription!.cancel();
    super.dispose();
  }

  void _editItemDialog(id) async {
    var dialog = await showDialog(
        barrierDismissible: true, //是否是模态对话框
        context: context,
        builder: (context) {
          return UnconstrainedBox(
            //在Dialog的外层添加一层UnconstrainedBox
            constrainedAxis: Axis.vertical,
            child: SizedBox(
              //再用SizeBox指定宽度
              width: 0.8.sw,
              child: Dialog(
                insetPadding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        changeDefaultAddress(id);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, right: 30.w),
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle, //可以设置角度，BoxShape.circle直接圆形
                        ),
                        child: Center(
                          child: Text(
                            '设为\n默认',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        deleteAddress(id);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle, //可以设置角度，BoxShape.circle直接圆形
                        ),
                        height: 50.h,
                        width: 50.h,
                        child: Center(
                          child: Text(
                            '删除\n地址',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
