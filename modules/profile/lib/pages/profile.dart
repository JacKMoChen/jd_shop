import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/constants/config.dart';
import 'package:common/utils/user_util.dart';
import 'package:common/event/event_user.dart';

/// @date on 2021/5/25 11:54
/// @author jack
/// @filename profile.dart
/// @description 我的

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  StreamSubscription? userEventSubscription;

  bool isLogin = false;
  var userInfo;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userEventSubscription = eventBus.on<UserEvent>().listen((event) {
      //显示属性面板
      if (mounted) {
        getUserInfo();
      }
    });
    getUserInfo();
  }

  @override
  void dispose() {
    userEventSubscription!.cancel();
    super.dispose();
  }

  void getUserInfo() {
    UserHelper.getUserInfo().then((value) {
      print(value);
      if (value.length > 0) {
        userInfo = value[0];
        isLogin = UserHelper.isLogin();
      } else {
        userInfo = null;
        isLogin = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      //设置单个页面状态栏图标颜色
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: MediaQuery.removePadding(
          //实现沉浸式状态栏
          removeTop: true,
          context: context,
          child: ListView(
            children: [
              //可以统一放在common中使用
              Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/user_bg.jpg",
                              package:
                                  AppHelper.isModuleRun ? null : 'profile'))),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w, right: 10.w),
                        child: ClipOval(
                          child: Image.asset(
                            "images/user.png",
                            package: AppHelper.isModuleRun ? null : 'profile',
                            fit: BoxFit.cover,
                            width: 50.h,
                            height: 50.h,
                          ),
                        ),
                      ),
                      isLogin
                          ? Expanded(
                              child: InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "用户名:${userInfo['username']}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14.sp),
                                  ),
                                  Text(
                                    "普通会员",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.sp),
                                  )
                                ],
                              ),
                            ))
                          : InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/user/login');
                              },
                              child: Text("登录/注册",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp)))
                    ],
                  )),
              ListTile(
                onTap: () {
                  if (isLogin) {
                    Navigator.pushNamed(context, "/order/orderList");
                  } else {
                    Navigator.pushNamed(context, '/user/login');
                  }
                },
                leading: Icon(Icons.assignment, color: Colors.red),
                title: Text("全部订单${String.fromEnvironment("module_name")}"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.payment, color: Colors.green),
                title: Text("待付款"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.location_on_outlined, color: Colors.orange),
                title: Text("待收货"),
              ),
              Divider(
                  thickness: 10.h, color: Color.fromRGBO(242, 242, 242, 0.9)),
              ListTile(
                leading: Icon(Icons.favorite, color: Colors.lightGreen),
                title: Text("我的收藏"),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.people_outline, color: Colors.black54),
                title: Text("在线客服"),
              ),
              Divider(),
              isLogin
                  ? InkWell(
                      onTap: () {
                        _logOutDialog();
                      },
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.black54),
                        title: Text("退出登录"),
                      ),
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }

  void _logOutDialog() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("提示"),
            content: Text("确认退出?"),
            actions: [
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: Text(
                  "取消",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              CupertinoButton(
                onPressed: () async {
                  UserHelper.logOut();
                  getUserInfo();
                  Navigator.pop(context, 'Ok');
                },
                child: Text(
                  "确定",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          );
        });
  }
}
