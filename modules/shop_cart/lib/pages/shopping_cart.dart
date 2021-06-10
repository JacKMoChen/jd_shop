import 'package:common/provider/cart.dart';
import 'package:common/utils/cart_util.dart';
import 'package:common/utils/user_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_cart/pages/cart_item.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  _isEdit = !_isEdit;
                });
              },
              child: Text(
                _isEdit ? "完成" : "管理",
                style: TextStyle(color: Colors.black87),
              ))
        ],
      ),
      body: Stack(
        children: [
          cartProvider.cartList.length > 0
              ? Container(
                  margin: EdgeInsets.only(bottom: 50.h),
                  child: ListView(
                    children: cartProvider.cartList.map((e) {
                      return CartItem(e);
                    }).toList(),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 200.h),
                  alignment: Alignment.center,
                  child: Column(
                    children: [Icon(Icons.hourglass_empty), Text("购物车空空如也")],
                  ),
                ),
          Positioned(
            bottom: 0,
            width: 1.sw,
            height: 50.h,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(color: Colors.black12, width: 1))),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                          value: cartProvider.cartGoodsAllChecked,
                          onChanged: (value) async {
                            setState(() {
                              cartProvider.cartGoodsAllChecked = value!;
                              cartProvider.cartList.forEach((element) {
                                element['checked'] =
                                    cartProvider.cartGoodsAllChecked;
                              });
                            });
                            await CartUtil.updateAllCheckedState(
                                cartProvider.cartGoodsAllChecked);
                            cartProvider.updateData();
                          },
                          activeColor: Colors.pink,
                        ),
                        Text("全选")
                      ],
                    ),
                  ),
                  _isEdit
                      ? Text("")
                      : Positioned(
                          top: 15.h,
                          right: 100.w,
                          child: Row(
                            children: [
                              Container(
                                child: Text("合计:"),
                              ),
                              Container(
                                child: Text(
                                  "￥${cartProvider.allPrice}",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          )),
                  _isEdit
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 5.h, 10.w, 5.h),
                            child: TextButton(
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(60.w, 25.h)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.black12),
                              ),
                              onPressed: () {
                                cartProvider.removeItem();
                              },
                              child: Text(
                                "删除",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 5.h, 10.w, 5.h),
                            child: TextButton(
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(60.w, 25.h)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                overlayColor:
                                    MaterialStateProperty.all(Colors.black12),
                              ),
                              onPressed: () {
                                if (UserHelper.isLogin()) {
                                  CartUtil.getSettlementData().then((value) {
                                    if (value.length > 0) {
                                      Navigator.pushNamed(
                                          context, "/shoppingCart/settlement");
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "未选中商品",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                      );
                                    }
                                  });
                                } else {
                                  Navigator.pushNamed(context, "/user/login");
                                }
                              },
                              child: Text(
                                "结算",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
