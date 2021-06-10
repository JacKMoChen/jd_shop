import 'package:common/net/http_request.dart';
import 'package:home/model/banner.dart';
import 'package:home/model/goods.dart';

/// @date on 2021/5/26 15:04
/// @author jack
/// @filename home_request.dart
/// @description 首页接口请求

class HomeRequest {
  //轮播图
  static Future<List<BannerItem>> getBannerList() async {
    // 1.构建URL
    final requestUrl = "api/focus";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl);

    // 3.将Map转成Model
    final results = data["result"];
    // 3.将Map转成Model
    List<BannerItem> banners = [];
    for (var sub in results) {
      banners.add(BannerItem.fromMap(sub)!);
    }
    return banners;
  }

  //猜你喜欢
  static Future<List<GoodsInfo>> getMayLikeList() async {
    // 1.构建URL
    final requestUrl = "api/plist?is_hot=1";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl);
    // 3.将Map转成Model
    final results = data["result"];
    // 3.将Map转成Model
    List<GoodsInfo> goods = [];
    for (var sub in results) {
      goods.add(GoodsInfo.fromMap(sub)!);
    }
    return goods;
  }

  static Future<List<GoodsInfo>> getHotRecommendList() async {
    // 1.构建URL
    final requestUrl = "api/plist?is_best=1";
    // 2.发送网络请求获取结果
    final data = await http.request(requestUrl);
    // 3.将Map转成Model
    final results = data["result"];
    // 3.将Map转成Model
    List<GoodsInfo> goods = [];
    for (var sub in results) {
      goods.add(GoodsInfo.fromMap(sub)!);
    }
    return goods;
  }
}
