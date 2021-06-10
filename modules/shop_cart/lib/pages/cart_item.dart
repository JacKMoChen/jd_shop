import 'package:common/utils/cart_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common/provider/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  Map itemData;

  CartItem(this.itemData, {Key? key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  void _deleteDialog() async {
    var dialog = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("确定删除?"),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                },
                child: Text("取消"),
              ),
              MaterialButton(
                onPressed: () async {
                  Provider.of<Cart>(context, listen: false).removeItemOne(
                      widget.itemData['_id'], widget.itemData['selectedAttr']);
                  Provider.of<Cart>(context, listen: false).updateData();
                  Navigator.pop(context, 'Ok');
                },
                child: Text("确定"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        //长按删除
        _deleteDialog();
      },
      child: Container(
        height: 100.h,
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: [
            Container(
                width: 30.w,
                child: Checkbox(
                  value: widget.itemData['checked'],
                  onChanged: (value) async {
                    setState(() {
                      widget.itemData['checked'] = value!;
                    });
                    await CartUtil.updateCheckedState(widget.itemData['_id'],
                        widget.itemData['selectedAttr'], value!);
                    Provider.of<Cart>(context, listen: false).updateData();
                  },
                  activeColor: Colors.pink,
                )),
            Container(
              width: 80.w,
              child: Image.network("${widget.itemData['pic']}"),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.itemData['title']}",
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Text("${widget.itemData['selectedAttr']}",
                        style: TextStyle(color: Colors.black54)),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "￥${widget.itemData['price']}",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: buildGoodsNum(),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget buildGoodsNum() {
    return Container(
      width: 67.w,
      height: 20.w,
      decoration:
          BoxDecoration(border: Border.all(width: 1.w, color: Colors.black12)),
      child: Row(
        children: [
          Container(
            width: 20.w,
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () async {
                  setState(() {
                    if (widget.itemData['count'] > 1) {
                      widget.itemData['count'] = widget.itemData['count'] - 1;
                    }
                  });
                  await CartUtil.reduceCount(
                      widget.itemData['_id'], widget.itemData['selectedAttr']);
                  Provider.of<Cart>(context, listen: false).updateData();
                },
                icon: Icon(
                  Icons.remove,
                  size: 10.h,
                )),
          ),
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 1.w, color: Colors.black12),
                      right: BorderSide(width: 1.w, color: Colors.black12))),
              width: 25.w,
              height: 20.w,
              child: Text(
                "${widget.itemData['count']}",
                textAlign: TextAlign.center,
              )),
          Container(
            width: 20.w,
            child: IconButton(
                onPressed: () async {
                  setState(() {
                    widget.itemData['count'] = widget.itemData['count'] + 1;
                  });
                  await CartUtil.addCount(
                      widget.itemData['_id'], widget.itemData['selectedAttr']);
                  Provider.of<Cart>(context, listen: false).updateData();
                },
                icon: Icon(
                  Icons.add,
                  size: 10.h,
                )),
          ),
        ],
      ),
    );
  }
}
