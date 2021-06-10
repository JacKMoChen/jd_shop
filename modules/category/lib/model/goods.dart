/// _id : "59f087ef11945e2760c852dd"
/// title : "笔记本电脑"
/// cid : "59f1e4919bfd8f3bd030eed6"
/// price : 2346
/// old_price : "4000"
/// pic : "public\\upload\\Hfe1i8QDOkfVt-PuGcxCA0fs.jpg"
/// s_pic : "public\\upload\\Hfe1i8QDOkfVt-PuGcxCA0fs.jpg_200x200.jpg"

class Goods {
  String? Id;
  String? title;
  String? cid;
  String? price;
  String? oldPrice;
  String? pic;
  String? sPic;

  static Goods? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    Goods goodsBean = Goods();
    goodsBean.Id = map['_id'];
    goodsBean.title = map['title'];
    goodsBean.cid = map['cid'];
    goodsBean.price = map['price'].toString();
    goodsBean.oldPrice = map['old_price'];
    goodsBean.pic = map['pic'];
    goodsBean.sPic = map['s_pic'];
    return goodsBean;
  }

  Map toJson() => {
        "_id": Id,
        "title": title,
        "cid": cid,
        "price": price,
        "old_price": oldPrice,
        "pic": pic,
        "s_pic": sPic,
      };
}
