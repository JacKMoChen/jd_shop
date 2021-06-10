/// _id : "59f1e1ada1da8b15d42234e9"
/// title : "电脑办公"
/// status : "1"
/// pic : "public\\upload\\FNIJ1lUH1bfuK82mbpIszetN.jpg"
/// pid : "0"
/// sort : "100"

class CategoryItem {
  String? Id;
  String? title;
  String? status;
  String? pic;
  String? pid;
  String? sort;

  static CategoryItem? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    CategoryItem categoryBean = CategoryItem();
    categoryBean.Id = map['_id'];
    categoryBean.title = map['title'];
    categoryBean.status = map['status'].toString();
    categoryBean.pic = map['pic'];
    categoryBean.pid = map['pid'];
    categoryBean.sort = map['sort'];
    return categoryBean;
  }

  Map toJson() => {
        "_id": Id,
        "title": title,
        "status": status,
        "pic": pic,
        "pid": pid,
        "sort": sort,
      };
}
