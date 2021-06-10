import 'package:category/model/category.dart';
import 'package:category/model/goods.dart';
import 'package:common/model/goods_detail.dart';
import 'package:common/net/http_request.dart';
import 'package:common/utils/string_util.dart';

/// @date on 2021/5/26 17:39
/// @author jack
/// @filename category_request.dart
/// @description 商品分类

class CategoryRequest {
  //分类数据
  static Future<List<CategoryItem>> getCategoryList(String? pid) async {
    // 1.构建URL
    final requestUrl = "api/pcate${pid == null ? "" : "?pid=$pid"}";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl);
    // 3.将Map转成Model
    final results = data["result"];
    // 3.将Map转成Model
    List<CategoryItem> categories = [];
    for (var sub in results) {
      categories.add(CategoryItem.fromMap(sub)!);
    }
    return categories;
  }

  //商品列表
  static Future<List<Goods>> getGoodsList(int page, int pageSize,
      {String? cid, String? search, String? sort}) async {
    // 1.构建URL
    final requestUrl =
        "api/plist${StringUtil.isEmpty(cid) ? "?" : "?cid=$cid&"}"
        "page=$page&pageSize=$pageSize${StringUtil.isEmpty(search) ? "" : "&search=$search"}${StringUtil.isEmpty(sort) ? "" : "&sort=$sort"}";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl);
    // 3.将Map转成Model
    final results = data["result"];
    // 3.将Map转成Model
    List<Goods> goods = [];
    for (var sub in results) {
      goods.add(Goods.fromMap(sub)!);
    }
    return goods;
  }

  //商品详情
  static Future<GoodsDetail> getGoodsDetail(String id) async {
    // 1.构建URL
    final requestUrl = "api/pcontent?id=$id";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl);
    // 3.将Map转成Model
    final result = data["result"];
    // 3.将Map转成Model
    return GoodsDetail.fromJson(result);
  }
}
