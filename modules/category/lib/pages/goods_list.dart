import 'package:category/api/category_request.dart';
import 'package:category/model/goods.dart';
import 'package:category/utils/search_util.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/constants/config.dart';
import 'package:common/utils/string_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodsListPage extends StatefulWidget {
  Map arguments;

  GoodsListPage({Key? key, required this.arguments}) : super(key: key);

  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> {
  int _selectIndex = 1; //tab选中index
  String _sort = ""; //排序
  String? _keyWords = ""; //搜索关键字
  List<Goods> goodsList = []; //商品数据
  int _page = 1;
  int _pageSize = 10;
  //价格升序 sort=price_1
  // 价格降序 sort=price_-1
  // 销量升序 sort=salecount_1
  // 销量降序 sort=salecount_-1
  List _subHeaderList = [
    {"id": 1, "title": "综合", "filed": "all_", "sort": -1},
    {"id": 2, "title": "销量", "filed": "salecount_", "sort": -1},
    {"id": 3, "title": "价格", "filed": "price_", "sort": -1},
    {"id": 4, "title": "筛选", "filed": "filter", "sort": 1}
  ];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    _keyWords = widget.arguments['keywords'];
    _textEditingController.text =
        (StringUtil.isEmpty(_keyWords) ? "" : _keyWords)!;
    getGoodsList();
    super.initState();
  }

  void getGoodsList() {
    CategoryRequest.getGoodsList(_page, _pageSize,
            cid: widget.arguments['goodsId'], search: _keyWords, sort: _sort)
        .then((res) {
      setState(() {
        goodsList.addAll(res);
      });
    });
  }

  void _onRefresh() async {
    _page = 1;
    goodsList.clear();
    getGoodsList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _page++;
    if (mounted) {
      getGoodsList();
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back),
        ),
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
              _keyWords = value;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              SearchUtil.setSearchData(_keyWords);
              _page = 1;
              widget.arguments['goodsId'] = null;
              goodsList.clear();
              getGoodsList();
            },
            child: Text(
              "搜索",
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
          )
        ],
      ),
      endDrawer: Drawer(
          child: Container(
        child: Text("筛选功能"),
      )),
      body: Stack(
        children: [buildGoodsList(), buildTopTab()],
      ),
    );
  }

  Widget buildTopTab() {
    return Positioned(
      top: 0,
      height: 40.h,
      width: 1.sw,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
            children: this._subHeaderList.map((value) {
              return Expanded(
                child: InkWell(
                  onTap: () {
                    _subTabChange(value["id"]);
                  },
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${value["title"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: _selectIndex == value["id"]
                                      ? Colors.red
                                      : Colors.black)),
                          buildSortArrow(value["id"])
                        ],
                      )),
                ),
              );
            }).toList(),
          )),
    );
  }

  showDialog() {
    Dialog dialog = Dialog();
  }

  Widget buildGoodsList() {
    return Container(
        margin: EdgeInsets.only(top: 40.h),
        padding: EdgeInsets.all(10.w),
        child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: goodsList.length > 0
                ? ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 90.w,
                                  height: 90.w,
                                  child: Image.network(
                                    "${HttpConfig.BASEURL + goodsList[index].pic!.replaceAll("\\", "/")}",
                                    fit: BoxFit.cover,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 90.w,
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${goodsList[index].title}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //Chip大小控制
                                        /* Transform(
                                    transform: new Matrix4.identity()..scale(0.7),
                                    child: Chip(
                                      label: Text(
                                        "111",
                                        textAlign: TextAlign.center,
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),*/
                                        Text(
                                          "￥${goodsList[index].price}",
                                          style: TextStyle(color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                          Divider(
                            height: 20.h,
                          )
                        ],
                      );
                    },
                    itemCount: goodsList.length)
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Text(
                          "暂无数据",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  )));
  }

  void _subTabChange(int id) {
    _selectIndex = id;
    if (_selectIndex == 4) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      _sort =
          "${this._subHeaderList[id - 1]["filed"]}${this._subHeaderList[id - 1]["sort"]}";
      _page = 1;
      this._subHeaderList[id - 1]["sort"] =
          -this._subHeaderList[id - 1]["sort"];
      goodsList.clear();
      getGoodsList();
      _scrollController.jumpTo(0);
    }
  }

  Widget buildSortArrow(id) {
    if (id == 2 || id == 3) {
      return Icon(this._subHeaderList[id - 1]["sort"] == 1
          ? Icons.arrow_drop_down
          : Icons.arrow_drop_up);
    } else {
      return Text("");
    }
  }
}
