import 'dart:convert';

import 'package:common/utils/shared_preferences_util.dart';
import 'package:common/utils/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/widgets/input_text.dart';
import 'package:user/api/user_request.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @date on 2021/6/4 10:51
/// @author jack
/// @filename register.dart
/// @description 注册步骤三

class RegisterThirdPage extends StatefulWidget {
  Map arguments;
  RegisterThirdPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String? phone;
  String? code;
  String? password;
  String? rePassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = widget.arguments['phone'];
    code = widget.arguments['code'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.w),
        child: ListView(
          children: [
            SizedBox(height: 40.h),
            InputText(
              prefixIcon: Icons.lock,
              isPwd: true,
              hintText: "请输入密码",
              onChanged: (value) {
                password = value;
              },
            ),
            InputText(
              isPwd: true,
              prefixIcon: Icons.lock,
              hintText: "确认密码",
              onChanged: (value) {
                rePassword = value;
              },
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                register();
              },
              child: Text("完成"),
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

  ///注册
  void register() {
    if (StringUtil.isEmpty(password) || StringUtil.isEmpty(rePassword)) {
      Fluttertoast.showToast(
        msg: "请输入正确密码",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    if (password == rePassword) {
      UserRequest.register(phone, code, password).then((result) {
        if (result['success']) {
          //保存用户信息
          SharedPreferenceUtil.putString(
              "userinfo", json.encode(result['userinfo']));
          Navigator.of(context)
              .popUntil(ModalRoute.withName('/')); //true保留跳转的当前栈   false 不保留
        }
      });
    } else {
      Fluttertoast.showToast(
        msg: "两次输入密码不一致",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
