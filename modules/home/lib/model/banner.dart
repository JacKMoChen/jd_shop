/// _id : "59f6ef443ce1fb0fb02c7a43"
/// title : "笔记本电脑"
/// status : "1"
/// pic : "public\\upload\\UObZahqPYzFvx_C9CQjU8KiX.png"
/// url : "12"

class BannerItem {
  String? Id;
  String? title;
  String? status;
  String? pic;
  String? url;

  static BannerItem? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    BannerItem bannerBean = BannerItem();
    bannerBean.Id = map['_id'];
    bannerBean.title = map['title'];
    bannerBean.status = map['status'];
    bannerBean.pic = map['pic'];
    bannerBean.url = map['url'];
    return bannerBean;
  }

  Map toJson() => {
        "_id": Id,
        "title": title,
        "status": status,
        "pic": pic,
        "url": url,
      };
}
