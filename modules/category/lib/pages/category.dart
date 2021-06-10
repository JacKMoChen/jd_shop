import 'package:category/api/category_request.dart';
import 'package:category/model/category.dart';
import 'package:common/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// @date on 2021/5/25 11:52
/// @author jack
/// @filename category.dart
/// @description 商品分类

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _leftIndex = 0;
  final List<CategoryItem> categories = [];
  final List<CategoryItem> goodsCategories = [];

  @override
  void initState() {
    super.initState();
    CategoryRequest.getCategoryList(null).then((res) => {
          setState(() {
            categories.addAll(res);
            //默认右侧第一个
            CategoryRequest.getCategoryList(categories[0].Id).then((res) => {
                  setState(() {
                    goodsCategories.clear();
                    goodsCategories.addAll(res);
                  })
                });
          })
        });
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
        body: Row(children: [buildLeftNav(), buildRightContent()]));
  }

  //右侧分类
  Widget buildRightContent() {
    return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.all(10.w),
            height: double.infinity,
            color: Color.fromRGBO(246, 246, 244, 1),
            child: GridView.builder(
                itemCount: goodsCategories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1.3,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w),
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(ctx, "/category/goodsList",
                          arguments: {"goodsId": goodsCategories[index].Id});
                    },
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(
                              "${HttpConfig.BASEURL + goodsCategories[index].pic!.replaceAll("\\", "/")}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            child: Text("${goodsCategories[index].title}"),
                          )
                        ],
                      ),
                    ),
                  );
                })));
  }

  //左侧导航栏
  Container buildLeftNav() {
    return Container(
        width: 0.25.sw,
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _leftIndex = index;
                      CategoryRequest.getCategoryList(categories[index].Id)
                          .then((res) => {
                                setState(() {
                                  goodsCategories.clear();
                                  goodsCategories.addAll(res);
                                })
                              });
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("${categories[index].title}"),
                    width: double.infinity,
                    height: 50.h,
                    color: _leftIndex == index
                        ? Color.fromRGBO(246, 246, 244, 1)
                        : Colors.white,
                  ),
                ),
                Divider(
                  height: 1,
                )
              ],
            );
          },
          itemCount: categories.length,
        ));
  }
}
