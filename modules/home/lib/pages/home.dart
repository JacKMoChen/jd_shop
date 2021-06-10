import 'package:common/constants/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/generated/l10n.dart';
import 'package:home/api/home_request.dart';
import 'package:home/model/banner.dart';
import 'package:home/model/goods.dart';

/// @date on 2021/5/25 11:48
/// @author jack
/// @filename home.dart
/// @description 首页

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<BannerItem> banners = [];
  final List<GoodsInfo> mayLikes = [];
  final List<GoodsInfo> hotRecommends = [];
  @override
  void initState() {
    //请求banner接口
    HomeRequest.getBannerList().then((res) {
      setState(() {
        banners.addAll(res);
      });
    });
    HomeRequest.getMayLikeList().then((res) {
      setState(() {
        mayLikes.addAll(res);
      });
    });
    HomeRequest.getHotRecommendList().then((res) {
      setState(() {
        hotRecommends.addAll(res);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.center_focus_weak,
            size: 24.sp,
            color: Colors.black54,
          ),
        ),
        title: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/category/search");
          },
          highlightColor: Colors.transparent, // 透明色
          splashColor: Colors.transparent, // 透明色
          child: Container(
              height: 30.h,
              padding: EdgeInsets.only(left: 10.w),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 0.8),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black45,
                    ),
                  )
                ],
              )),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              size: 24.sp,
              color: Colors.black54,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          buildSwiper(),
          SizedBox(height: 10.h),
          buildTitle(S.of(context).title_may_like),
          SizedBox(height: 10.h),
          buildMayLikeList(),
          SizedBox(height: 10.h),
          buildTitle(S.of(context).title_hot_recommend),
          SizedBox(height: 10.h),
          buildHotRecommendList()
        ],
      ),
    );
  }

  //轮播图
  Widget buildSwiper() {
    return Container(
        height: 200.h,
        child: new Swiper(
            itemBuilder: (BuildContext context, int index) {
              return new Image.network(
                "${HttpConfig.BASEURL + banners[index].pic!.replaceAll("\\", "/")}",
                fit: BoxFit.fill,
              );
            },
            itemCount: banners.length,
            autoplay: true,
            pagination: new SwiperPagination()));
  }

  Widget buildTitle(String title) {
    return Container(
        height: 23.h,
        margin: EdgeInsets.only(left: 10.w),
        padding: EdgeInsets.only(left: 5.w),
        decoration: BoxDecoration(
            border: Border(left: BorderSide(color: Colors.red, width: 5.w))),
        child: Text(
          title,
          style: TextStyle(color: Colors.black54, fontSize: 14.sp),
        ));
  }

  //猜你喜欢list
  Widget buildMayLikeList() {
    return Container(
      height: 100.h,
      width: 80.w,
      padding: EdgeInsets.only(left: 10.w),
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              Container(
                height: 80.h,
                width: 60.w,
                margin: EdgeInsets.only(right: 10.w),
                child: Image.network(
                  "${HttpConfig.BASEURL + mayLikes[index].pic!.replaceAll("\\", "/")}",
                ),
              ),
              Text(
                "￥${mayLikes[index].price}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          );
        },
        itemCount: mayLikes.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

//热门推荐列表
  Widget buildHotRecommendList() {
    return Container(
        padding: EdgeInsets.all(10.w),
        child: Wrap(
          runSpacing: 10.w, //交叉轴上子控件之间的间距
          spacing: 10.w, //主轴上子控件的间距
          children: List.generate(
            hotRecommends.length,
            (index) {
              return buildHotRecommendListItem(index);
            },
          ),
        ));
  }

  //热门推荐Item
  Widget buildHotRecommendListItem(int index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/category/goodsDetail",
            arguments: {"id": hotRecommends[index].Id});
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Color.fromRGBO(233, 233, 233, 0.9), width: 1.w)),
        width: (1.sw - 31.w) / 2,
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            //设置图片宽高比
            Container(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.network(
                  "${HttpConfig.BASEURL + hotRecommends[index].pic!.replaceAll("\\", "/")}",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                "${hotRecommends[index].title}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "￥${hotRecommends[index].price}",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.sp,
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text("￥${hotRecommends[index].oldPrice}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14.sp,
                            decoration: TextDecoration.lineThrough)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
