import 'package:category/utils/search_util.dart';
import 'package:common/utils/shared_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsSearchPage extends StatefulWidget {
  @override
  _GoodsSearchPageState createState() => _GoodsSearchPageState();
}

class _GoodsSearchPageState extends State<GoodsSearchPage> {
  String keyWords = "";
  List historyList = [];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    reloadHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 30.h,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10.w),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: "搜索内容",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(0), //文本垂直居中
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
                /* suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.clear_rounded,
                      size: 18.sp,
                      color: Colors.black54,
                    ),
                  )*/
              ),
              autofocus: false,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black45,
              ),
              onChanged: (value) {
                keyWords = value;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                SearchUtil.setSearchData(keyWords);
                Navigator.pushReplacementNamed(context, "/category/goodsList",
                    arguments: {"keywords": keyWords});
              },
              child: Text(
                "搜索",
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                  child: Text(
                "热搜",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Divider(),
              Wrap(
                children: [
                  Transform(
                    transform: new Matrix4.identity()..scale(0.7),
                    child: RawChip(
                      onPressed: () {},
                      label: Text(
                        "笔记本",
                        textAlign: TextAlign.center,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                ],
              ),
              Container(
                  child: Text(
                "历史记录",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              buildHistoryList(),
            ],
          ),
        ));
  }

  Widget buildHistoryList() {
    return historyList.length == 0
        ? Center(child: Text("暂无历史记录"))
        : Column(
            children: [
              Column(
                children: historyList.map((e) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          keyWords = e;
                          _textEditingController.text = keyWords;
                          SearchUtil.setSearchData(keyWords);
                          Navigator.pushReplacementNamed(
                              context, "/category/goodsList",
                              arguments: {"keywords": keyWords});
                        },
                        onLongPress: () {
                          _deleteHistoryDialog(e);
                        },
                        child: ListTile(title: Text("$e")),
                      ),
                      Divider(
                        height: 5.h,
                      )
                    ],
                  );
                }).toList(),
              ),
              SizedBox(
                height: 50.h,
              ),
              OutlinedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    foregroundColor: MaterialStateProperty.all(Colors.black45),
                    overlayColor: MaterialStateProperty.all(Colors.black12),
                    minimumSize: MaterialStateProperty.all(Size(300.w, 30.h)),
                    /* side: MaterialStateProperty.all(
                        BorderSide(color: Colors.grey, width: 1)),
                    //外边框装饰 会覆盖 side 配置的样式
                    shape: MaterialStateProperty.all(StadiumBorder()),*/
                  ),
                  onPressed: () {
                    SearchUtil.clear("searchList");
                    reloadHistoryData();
                  },
                  icon: Icon(Icons.delete_outline),
                  label: Text("清空历史记录"))
            ],
          );
  }

  void reloadHistoryData() {
    SearchUtil.getSearchData().then((value) {
      setState(() {
        historyList = value;
      });
    });
  }

  void _deleteHistoryDialog(keyWords) async {
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
                  await SearchUtil.remove(keyWords);
                  reloadHistoryData();
                  Navigator.pop(context, 'Ok');
                },
                child: Text("确定"),
              )
            ],
          );
        });
  }
}
