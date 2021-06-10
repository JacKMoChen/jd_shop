import 'dart:convert';

import 'package:common/utils/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/widgets/input_text.dart';
import 'package:user/api/user_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:common/event/event_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "客服",
                style: TextStyle(color: Colors.black87),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.h),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30.h),
              child: Icon(
                  IconData(0xe605,
                      fontFamily: 'iconfont', fontPackage: "common"),
                  color: Colors.red,
                  size: 30.sp),
            ),
            SizedBox(height: 30.h),
            InputText(
              prefixIcon: Icons.people,
              hintText: "用户名",
              onChanged: (value) {
                userName = value;
              },
            ),
            SizedBox(height: 10.h),
            InputText(
                isPwd: true,
                prefixIcon: Icons.lock,
                hintText: "密码",
                onChanged: (value) {
                  password = value;
                }),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {},
                    child: Text("忘记密码？", style: TextStyle(color: Colors.grey))),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/user/registerFirst");
                    },
                    child: Text("新用户注册", style: TextStyle(color: Colors.grey))),
              ],
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text("登录"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(Colors.black12),
                minimumSize: MaterialStateProperty.all(Size(100.w, 40.h)),
                /* side: MaterialStateProperty.all(
                                BorderSide(color: Colors.grey, width: 1)),
                            //外边框装饰 会覆盖 side 配置的样式
                            shape: MaterialStateProperty.all(StadiumBorder()),*/
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login() {
    UserRequest.login(userName, password).then((result) {
      if (result['success']) {
        SharedPreferenceUtil.putString(
            "userinfo", json.encode(result['userinfo']));
        Navigator.of(context).pop();
      }
      Fluttertoast.showToast(
        msg: result['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    });
  }

  @override
  void dispose() {
    eventBus.fire(UserEvent('event_login_success'));
    super.dispose();
  }
}
