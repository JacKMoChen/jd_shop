import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/widgets/input_text.dart';
import 'package:user/api/user_request.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// @date on 2021/6/4 10:51
/// @author jack
/// @filename register.dart
/// @description 注册步骤二

class RegisterSecondPage extends StatefulWidget {
  Map arguments;
  RegisterSecondPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _RegisterSecondPageState createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String? phone = "";
  String? btnText = "60s";
  String? code;
  Timer? _timer;
  int _startTime = 60;
  bool isEnableSend = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = widget.arguments['phone'];
    sendCode();
  }

  void sendCode() {
    _startTime = 60;
    isEnableSend = false;
    setState(() {});
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      ///定时任务
      btnText = "${_startTime}s";

      if (_startTime < 1) {
        _timer!.cancel();
        isEnableSend = true;
        btnText = "重新发送";
      } else {
        _startTime--;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer!.cancel();
    super.dispose();
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
            Container(
                child: Text(
              "验证码已发送到${phone!.replaceRange(phone!.length - 4, phone!.length, "****")}",
              style: TextStyle(color: Colors.grey),
            )),
            SizedBox(height: 30.h),
            Stack(
              children: [
                InputText(
                  hintText: "请输入验证码",
                  onChanged: (value) {
                    code = value;
                  },
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: ElevatedButton(
                    onPressed: isEnableSend
                        ? () {
                            sendCode();
                            //调用接口重新发送
                            sendSMSCode();
                          }
                        : null,
                    child: Text("$btnText"),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                validateCode();
              },
              child: Text("下一步"),
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

  void sendSMSCode() {
    RegExp reg = RegExp(r"^1\d{10}$");
    if (reg.hasMatch(phone!)) {
      UserRequest.sendCode(phone!).then((result) {
        if (result['success']) {
          print(result);
          Navigator.pushNamed(context, "/user/registerSecond",
              arguments: {"phone": phone});
        } else {
          Fluttertoast.showToast(
            msg: result['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      });
    } else {
      Fluttertoast.showToast(
        msg: "请输入正确的手机号",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void validateCode() {
    UserRequest.validateCode(phone!, code!).then((result) {
      if (result['success']) {
        print(result);
        Navigator.pushNamed(context, "/user/registerThird",
            arguments: {"phone": phone, "code": code});
      } else {
        Fluttertoast.showToast(
          msg: result['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }
}
