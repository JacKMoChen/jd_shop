import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/widgets/input_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user/api/user_request.dart';

/// @date on 2021/6/4 10:51
/// @author jack
/// @filename register.dart
/// @description 注册步骤一

class RegisterFirstPage extends StatefulWidget {
  const RegisterFirstPage({Key? key}) : super(key: key);

  @override
  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: ListView(
          children: [
            SizedBox(height: 40.h),
            InputText(
              prefixIcon: Icons.people,
              hintText: "请输入手机号",
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                FilteringTextInputFormatter(RegExp("[0-9]"), allow: true)
              ],
              onChanged: (value) {
                phone = value;
              },
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: () {
                sendSMSCode();
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

  ///发送短信验证码
  void sendSMSCode() {
    RegExp reg = RegExp(r"^1\d{10}$");
    if (reg.hasMatch(phone)) {
      UserRequest.sendCode(phone).then((result) {
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
}
