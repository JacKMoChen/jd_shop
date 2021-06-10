/// _id : "59f087ef11945e2760c852dd"
/// title : "笔记本电脑"
/// cid : "59f1e4919bfd8f3bd030eed6"
/// price : 2346
/// old_price : "4000"
/// pic : "public\\upload\\Hfe1i8QDOkfVt-PuGcxCA0fs.jpg"
/// s_pic : "public\\upload\\Hfe1i8QDOkfVt-PuGcxCA0fs.jpg_200x200.jpg"

class GoodsInfo {
  String? Id;
  String? title;
  String? cid;
  String? price;
  String? oldPrice;
  String? pic;
  String? sPic;

  static GoodsInfo? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    GoodsInfo mayLikeBean = GoodsInfo();
    mayLikeBean.Id = map['_id'];
    mayLikeBean.title = map['title'];
    mayLikeBean.cid = map['cid'];
    mayLikeBean.price = map['price'].toString();
    mayLikeBean.oldPrice = map['old_price'];
    mayLikeBean.pic = map['pic'];
    mayLikeBean.sPic = map['s_pic'];
    return mayLikeBean;
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
