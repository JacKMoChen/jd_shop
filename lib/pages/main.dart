import 'package:badges/badges.dart';
import 'package:category/pages/category.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/provider/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/r.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home/pages/home.dart';
import 'package:profile/pages/profile.dart';
import 'package:provider/provider.dart';
import 'package:shop_cart/pages/shopping_cart.dart';

/// @date on 2021/5/25 10:50
/// @author jack
/// @filename main.dart
/// @description App主页

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final _pages = [
    HomePage(),
    CategoryPage(),
    ShoppingCartPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  //底部导航栏
  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      fixedColor: Colors.red,
      selectedFontSize: 14.sp,
      unselectedFontSize: 14.sp,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: S.of(context).tab_home),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), label: S.of(context).tab_category),
        BottomNavigationBarItem(
            icon: Badge(
                showBadge: Provider.of<Cart>(context).allCount > 0,
                padding: EdgeInsets.all(3),
                badgeContent: Text(
                  '${Provider.of<Cart>(context).allCount}',
                  style: TextStyle(color: Colors.white, fontSize: 8.sp),
                ),
                child: Icon(Icons.shopping_cart)),
            label: S.of(context).tab_shop_cart),
        BottomNavigationBarItem(
            icon: Icon(Icons.people), label: S.of(context).tab_profile)
      ],
    );
  }
}
