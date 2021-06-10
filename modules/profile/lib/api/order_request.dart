import 'package:common/net/http_request.dart';
import 'package:common/net/sign_util.dart';
import 'package:profile/model/order.dart';

/// @date on 2021/6/9 15:46
/// @author jack
/// @filename order_request.dart
/// @description 订单api

class OrderRequest {
  static Future<List<Order>> getOrderList(Map<String, dynamic> params) async {
    // 1.构建URL
    final requestUrl = "api/orderList";
    final sign = SignUtil.getSign(params);
    params.remove("salt");
    params['sign'] = sign;
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl, params: params);
    List<Order> dataList = [];
    final results = data["result"];
    for (var sub in results) {
      dataList.add(Order.fromJson(sub));
    }

    return dataList;
  }
}
