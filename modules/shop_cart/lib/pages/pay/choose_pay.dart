import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @date on 2021/6/9 15:52
/// @author jack
/// @filename ChoosePayPage.dart
/// @description 选择支付

class ChoosePayPage extends StatefulWidget {
  const ChoosePayPage({Key? key}) : super(key: key);

  @override
  _ChoosePayPageState createState() => _ChoosePayPageState();
}

class _ChoosePayPageState extends State<ChoosePayPage> {
  List payList = [
    {
      "title": "支付宝",
      "checked": true,
      "icon": "https://www.itying.com/themes/itying/images/alipay.png"
    },
    {
      "title": "微信",
      "checked": false,
      "icon": "https://www.itying.com/themes/itying/images/weixinpay.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("去支付"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            Container(
              height: 200.h,
              child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            for (var i = 0; i < payList.length; i++) {
                              payList[i]['checked'] = (i == index);
                            }
                            setState(() {});
                          },
                          leading: Image.network("${payList[index]['icon']}"),
                          title: Text("${payList[index]['title']}"),
                          trailing: payList[index]['checked']
                              ? Icon(Icons.check)
                              : null,
                        ),
                        Divider()
                      ],
                    );
                  },
                  itemCount: payList.length),
            ),
            Container(
              margin: EdgeInsets.only(top: 80.h),
              child: TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(300.w, 40.h)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                ),
                onPressed: () {
                  print("popUntil");
                  Navigator.of(context).popUntil(ModalRoute.withName('/'));
                },
                child: Text(
                  "去支付",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
