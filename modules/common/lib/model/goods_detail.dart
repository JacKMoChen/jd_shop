/// _id : "5a0432f4010e71123466144c"
/// title : "八匹狼羽绒服男--有属性"
/// cid : "59f1e4f49bfd8f3bd030eed9"
/// price : "288"
/// old_price : "588"
/// is_best : 1
/// is_hot : "0"
/// is_new : "0"
/// attr : [{"cate":"尺寸","list":["185","175","165 "]},{"cate":"颜色","list":["红色","白色","黄色"]}]
/// status : "1"
/// pic : "public\\upload\\agbBbaTUWBnWD7pYQOyJsNgJ.png"
/// content : "<ul class=\"parameter2 p-parameter-list\"><li title=\"立领\">领型：立领</li><li title=\"外穿\">穿着方式：外穿</li><li title=\"红色，蓝色，黑色，灰色，绿色，橙色\">颜色：红色，蓝色，黑色，灰色，绿色，橙色</li><li title=\"纯色\">图案：纯色</li><li title=\"白鸭绒\">填充物：白鸭绒</li><li title=\"日常，旅游，居家，休闲\">适用场景：日常，旅游，居家，休闲</li><li title=\"青年\">人群：青年</li><li title=\"标准型\">版型：标准型</li><li title=\"90%以上\">含绒量：90%以上</li><li title=\"100g以下（不含）\">充绒量：100g以下（不含）</li><li title=\"锦纶\">面料主材质：锦纶</li><li title=\"商务绅士\">基础风格：商务绅士</li><li title=\"S，M，L，XL，XXL，XXXL\">尺码：S，M，L，XL，XXL，XXXL</li><li title=\"短款\">衣长：短款</li><li title=\"2017冬季\">上市时间：2017冬季</li></ul>                                                                                                                                                                                                                                                        <img src=\"http://img13.360buyimg.com/cms/jfs/t11866/290/1311381428/103929/73da9d35/5a003766N62f57de4.jpg\" usemap=\"#Mapss\" alt=\"\" width=\"990\" height=\"300\" />"
/// cname : "羽绒服"
/// salecount : 115
/// sub_title : "2017冬装新款商务休闲男士短款轻薄羽绒外套立领防风御寒保暖男装"

class GoodsDetail {
  String? _id;
  String? _title;
  String? _cid;
  String? _price;
  String? _oldPrice;
  String? _isBest;
  String? _isHot;
  String? _isNew;
  List<Attr>? _attr;
  String? _status;
  String? _pic;
  String? _content;
  String? _cname;
  int? _salecount;
  String? _subTitle;
  int? _selectCount;
  String? _selectAttr;

  String? get id => _id;
  String? get title => _title;
  String? get cid => _cid;
  String? get price => _price;
  String? get oldPrice => _oldPrice;
  String? get isBest => _isBest;
  String? get isHot => _isHot;
  String? get isNew => _isNew;
  List<Attr>? get attr => _attr;
  String? get status => _status;
  String? get pic => _pic;
  String? get content => _content;
  String? get cname => _cname;
  int? get salecount => _salecount;
  String? get subTitle => _subTitle;
  int? get selectCount => _selectCount;
  String? get selectAttr => _selectAttr;

  set selectCount(int? value) {
    _selectCount = value;
  }

  set salecount(int? value) {
    _salecount = value;
  }

  GoodsDetail(
      {String? id,
      String? title,
      String? cid,
      String? price,
      String? oldPrice,
      String? isBest,
      String? isHot,
      String? isNew,
      List<Attr>? attr,
      String? status,
      String? pic,
      String? content,
      String? cname,
      int? salecount,
      String? subTitle,
      int? selectCount,
      String? selectAttr}) {
    _id = id;
    _title = title;
    _cid = cid;
    _price = price;
    _oldPrice = oldPrice;
    _isBest = isBest;
    _isHot = isHot;
    _isNew = isNew;
    _attr = attr;
    _status = status;
    _pic = pic;
    _content = content;
    _cname = cname;
    _salecount = salecount;
    _subTitle = subTitle;
    _selectCount = selectCount;
    _selectAttr = _selectAttr;
  }

  GoodsDetail.fromJson(dynamic json) {
    _id = json["_id"];
    _title = json["title"];
    _cid = json["cid"];
    _price = json["price"].toString();
    _oldPrice = json["old_price"].toString();
    _isBest = json["is_best"].toString();
    _isHot = json["is_hot"].toString();
    _isNew = json["is_new"].toString();
    if (json["attr"] != null) {
      _attr = [];
      json["attr"].forEach((v) {
        _attr?.add(Attr.fromJson(v));
      });
    }
    _status = json["status"];
    _pic = json["pic"];
    _content = json["content"];
    _cname = json["cname"];
    _salecount = json["salecount"];
    _subTitle = json["sub_title"];
    _selectCount = 1;
    _selectAttr = "";
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["title"] = _title;
    map["cid"] = _cid;
    map["price"] = _price;
    map["old_price"] = _oldPrice;
    map["is_best"] = _isBest;
    map["is_hot"] = _isHot;
    map["is_new"] = _isNew;
    if (_attr != null) {
      map["attr"] = _attr?.map((v) => v.toJson()).toList();
    }
    map["status"] = _status;
    map["pic"] = _pic;
    map["content"] = _content;
    map["cname"] = _cname;
    map["salecount"] = _salecount;
    map["sub_title"] = _subTitle;
    return map;
  }

  set selectAttr(String? value) {
    _selectAttr = value;
  }
}

/// cate : "尺寸"
/// list : ["185","175","165 "]

class Attr {
  String? _cate;
  List<String>? _list;
  List<Map>? _attrList;

  List<Map>? get attrList => _attrList;

  set attrList(List<Map>? value) {
    _attrList = value;
  }

  int _selectIndex = 0;

  set selectIndex(int value) {
    _selectIndex = value;
  }

  String? get cate => _cate;
  List<String>? get list => _list;

  int get selectIndex => _selectIndex;

  Attr({String? cate, List<String>? list}) {
    _cate = cate;
    _list = list;
  }

  Attr.fromJson(dynamic json) {
    _cate = json["cate"];
    _list = json["list"] != null ? json["list"].cast<String>() : [];
    _attrList = [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["cate"] = _cate;
    map["list"] = _list;
    return map;
  }
}
