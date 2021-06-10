import 'package:common/net/http_request.dart';
import 'package:common/net/sign_util.dart';
import 'package:shop_cart/model/address.dart';

class AddressRequest {
  static Future<dynamic> addAddress(Map<String, dynamic> params) async {
    // 1.构建URL
    final requestUrl = "api/addAddress";
    final sign = SignUtil.getSign(params);
    params.remove("salt");
    params['sign'] = sign;
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl, method: "post", data: params);
    return data;
  }

  static Future<List<Address>> getAddressList(
      Map<String, dynamic> params) async {
    // 1.构建URL
    final requestUrl = "api/addressList";
    final sign = SignUtil.getSign(params);
    params.remove("salt");
    params['sign'] = sign;
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl, params: params);
    // 3.将Map转成Model
    final results = data["result"];
    // 3.将Map转成Model
    List<Address> dataList = [];
    for (var sub in results) {
      dataList.add(Address.fromJson(sub));
    }
    return dataList;
  }

  ///获取默认收货地址
  static Future<Address?> getDefaultAddress(Map<String, dynamic> params) async {
    // 1.构建URL
    final requestUrl = "api/oneAddressList";
    final sign = SignUtil.getSign(params);
    params.remove("salt");
    params['sign'] = sign;
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl, params: params);
    // 3.将Map转成Model
    final results = data["result"];
    // 3.将Map转成Model
    List<Address> dataList = [];
    for (var sub in results) {
      dataList.add(Address.fromJson(sub));
    }
    return dataList.length > 0 ? dataList[0] : null;
  }

  ///修改默认收货地址
  static Future<dynamic> changeDefaultAddress(
      Map<String, dynamic> params) async {
    // 1.构建URL
    final requestUrl = "api/changeDefaultAddress";
    final sign = SignUtil.getSign(params);
    params.remove("salt");
    params['sign'] = sign;
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl, method: "post", data: params);
    // 3.将Map转成Model
    return data;
  }

  ///删除收货地址
  static Future<dynamic> deleteAddress(Map<String, dynamic> params) async {
    // 1.构建URL
    final requestUrl = "api/deleteAddress";
    final sign = SignUtil.getSign(params);
    params.remove("salt");
    params['sign'] = sign;
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl, method: "post", data: params);
    // 3.将Map转成Model
    return data;
  }

  static Future<dynamic> editAddress(Map<String, dynamic> params) async {
    // 1.构建URL
    final requestUrl = "api/editAddress";
    final sign = SignUtil.getSign(params);
    params.remove("salt");
    params['sign'] = sign;
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl, method: "post", data: params);
    return data;
  }
}
