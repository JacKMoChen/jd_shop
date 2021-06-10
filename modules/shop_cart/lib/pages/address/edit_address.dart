import 'package:city_picker/city_picker.dart';
import 'package:common/event/event_address.dart';
import 'package:common/utils/user_util.dart';
import 'package:common/widgets/input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_cart/api/address_request.dart';
import 'package:shop_cart/model/address.dart';

/// @date on 2021/6/7 14:29
/// @author jack
/// @filename add_address.dart
/// @description 修改收货地址

class EditAddressPage extends StatefulWidget {
  Map arguments;

  EditAddressPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late Address _address;
  @override
  void initState() {
    _address = Address.fromJson(widget.arguments);
    editingController.text = _address.area!;
    super.initState();
  }

  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改收货地址"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.w),
        child: ListView(
          children: [
            InputText(
              editingController: TextEditingController.fromValue(
                  TextEditingValue(text: _address.name!)),
              labelText: "收货人",
              hintText: "请填写收货人姓名",
              onChanged: (value) {
                _address.name = value;
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            InputText(
              editingController: TextEditingController.fromValue(
                  TextEditingValue(text: _address.phone!)),
              labelText: "手机号码",
              hintText: "请填写收货人手机号码",
              onChanged: (value) {
                _address.phone = value;
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
                  editingController: editingController,
                  labelText: "所在地区",
                  prefixStyle: TextStyle(color: Colors.black87),
                  hintText: "收货地址",
                  enabled: false),
            ),
            SizedBox(
              height: 10.h,
            ),
            InputText(
              editingController: TextEditingController.fromValue(
                  TextEditingValue(text: _address.detailAddress!)),
              labelText: "详细地址",
              hintText: "街道、楼牌号等",
              maxLines: 3,
              onChanged: (value) {
                _address.detailAddress = value;
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
                  editAddress();
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

  void editAddress() {
    var params = {
      "uid": "${UserHelper.userinfo[0]['_id']}",
      "id": _address.id,
      "name": _address.name,
      "phone": _address.phone,
      "address": "${_address.area} ${_address.detailAddress}",
      "salt": "${UserHelper.userinfo[0]['salt']}"
    };
    AddressRequest.editAddress(params).then((result) {
      Fluttertoast.showToast(
        msg: result['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      if (result['success']) {
        eventBus.fire(AddressEvent('event_edit_address'));
        Navigator.pop(context);
      }
    });
  }

  ///城市选择器
  void _showCityPicker() async {
    Result? result = await CityPickers.showCityPicker(
        context: context, theme: ThemeData(primaryColor: Colors.blue));
    _address.area =
        "${result!.provinceName! + result.cityName! + result.areaName!}";
    editingController.text = _address.area!;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
