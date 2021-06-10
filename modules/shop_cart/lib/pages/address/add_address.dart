import 'package:common/utils/user_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common/widgets/input_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:city_picker/city_picker.dart';
import 'package:shop_cart/api/address_request.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:common/event/event_address.dart';

/// @date on 2021/6/7 14:29
/// @author jack
/// @filename add_address.dart
/// @description 添加收货地址

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String? name;
  String? phone;
  String? address;
  String? area;
  String? detailAddress;
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("添加收货地址"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.w),
        child: ListView(
          children: [
            InputText(
              labelText: "收货人",
              hintText: "请填写收货人姓名",
              onChanged: (value) {
                name = value;
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            InputText(
              labelText: "手机号码",
              hintText: "请填写收货人手机号码",
              onChanged: (value) {
                phone = value;
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                _showCityPicker();
              },
              child: InputText(
                labelText: "所在地区",
                prefixStyle: TextStyle(color: Colors.black87),
                editingController: editingController,
                hintText: "收货地址",
                enabled: false,
                onChanged: (value) {
                  area = value;
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            InputText(
              labelText: "详细地址",
              hintText: "街道、楼牌号等",
              maxLines: 3,
              onChanged: (value) {
                detailAddress = value;
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                  minimumSize: MaterialStateProperty.all(Size(300.w, 40.h)),
                  /* side: MaterialStateProperty.all(
                        BorderSide(color: Colors.grey, width: 1)),
                    //外边框装饰 会覆盖 side 配置的样式
                    shape: MaterialStateProperty.all(StadiumBorder()),*/
                ),
                onPressed: () {
                  var params = {
                    "uid": "${UserHelper.userinfo[0]['_id']}",
                    "name": name,
                    "phone": phone,
                    "address": "$area $detailAddress",
                    "salt": "${UserHelper.userinfo[0]['salt']}"
                  };
                  AddressRequest.addAddress(params).then((result) {
                    Fluttertoast.showToast(
                      msg: result['message'],
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                    );
                    if (result['success']) {
                      eventBus.fire(AddressEvent('event_add_address'));
                      Navigator.pop(context);
                    }
                  });
                },
                child: Text(
                  "保存",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  ///城市选择器
  void _showCityPicker() async {
    Result? result = await CityPickers.showCityPicker(
        context: context, theme: ThemeData(primaryColor: Colors.blue));
    editingController.text =
        "${result!.provinceName! + result.cityName! + result.areaName!}";
    area = editingController.text;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
