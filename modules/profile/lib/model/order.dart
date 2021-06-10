/// _id : "60c0726f2b08750c34eae598"
/// uid : "60b9d74af98bbd1004bb6208"
/// name : "lisi"
/// phone : "123456789"
/// address : "山西省太原市小店区 99999"
/// all_price : "9227.0"
/// pay_status : 0
/// order_status : 0
/// order_item : [{"_id":"60c0726f2b08750c34eae599","order_id":"60c0726f2b08750c34eae598","product_title":"磨砂牛皮男休闲鞋-有属性","product_id":"5a0425bc010e711234661439","product_price":"688","product_img":"http://jd.itying.com/public/upload/RinsvExKu7Ed-ocs_7W1DxYO.png","product_count":11,"selected_attr":null,"add_time":1623224943080},{"_id":"60c0726f2b08750c34eae59a","order_id":"60c0726f2b08750c34eae598","product_title":"磨砂牛皮男休闲鞋-有属性","product_id":"5a0425bc010e711234661439","product_price":"688","product_img":"http://jd.itying.com/public/upload/RinsvExKu7Ed-ocs_7W1DxYO.png","product_count":1,"selected_attr":null,"add_time":1623224943099},{"_id":"60c0726f2b08750c34eae59b","order_id":"60c0726f2b08750c34eae598","product_title":"磨砂牛皮男休闲鞋-有属性","product_id":"5a0425bc010e711234661439","product_price":"688","product_img":"http://jd.itying.com/public/upload/RinsvExKu7Ed-ocs_7W1DxYO.png","product_count":1,"selected_attr":null,"add_time":1623224943103},{"_id":"60c0726f2b08750c34eae59c","order_id":"60c0726f2b08750c34eae598","product_title":"八匹狼羽绒服男--有属性","product_id":"5a0432f4010e71123466144c","product_price":"288","product_img":"http://jd.itying.com/public/upload/agbBbaTUWBnWD7pYQOyJsNgJ.png","product_count":1,"selected_attr":null,"add_time":1623224943115}]

class Order {
  String? _id;
  String? _uid;
  String? _name;
  String? _phone;
  String? _address;
  String? _allPrice;
  int? _payStatus;
  int? _orderStatus;
  List<ProductItem>? _orderItem;

  String? get id => _id;
  String? get uid => _uid;
  String? get name => _name;
  String? get phone => _phone;
  String? get address => _address;
  String? get allPrice => _allPrice;
  int? get payStatus => _payStatus;
  int? get orderStatus => _orderStatus;
  List<ProductItem>? get orderItem => _orderItem;

  Order(
      {String? id,
      String? uid,
      String? name,
      String? phone,
      String? address,
      String? allPrice,
      int? payStatus,
      int? orderStatus,
      List<ProductItem>? orderItem}) {
    _id = id;
    _uid = uid;
    _name = name;
    _phone = phone;
    _address = address;
    _allPrice = allPrice;
    _payStatus = payStatus;
    _orderStatus = orderStatus;
    _orderItem = orderItem;
  }

  Order.fromJson(dynamic json) {
    _id = json["_id"];
    _uid = json["uid"];
    _name = json["name"];
    _phone = json["phone"];
    _address = json["address"];
    _allPrice = json["all_price"];
    _payStatus = json["pay_status"];
    _orderStatus = json["order_status"];
    if (json["order_item"] != null) {
      _orderItem = [];
      json["order_item"].forEach((v) {
        _orderItem?.add(ProductItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["uid"] = _uid;
    map["name"] = _name;
    map["phone"] = _phone;
    map["address"] = _address;
    map["all_price"] = _allPrice;
    map["pay_status"] = _payStatus;
    map["order_status"] = _orderStatus;
    if (_orderItem != null) {
      map["order_item"] = _orderItem?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "60c0726f2b08750c34eae599"
/// order_id : "60c0726f2b08750c34eae598"
/// product_title : "磨砂牛皮男休闲鞋-有属性"
/// product_id : "5a0425bc010e711234661439"
/// product_price : "688"
/// product_img : "http://jd.itying.com/public/upload/RinsvExKu7Ed-ocs_7W1DxYO.png"
/// product_count : 11
/// selected_attr : null
/// add_time : 1623224943080

class ProductItem {
  String? _id;
  String? _orderId;
  String? _productTitle;
  String? _productId;
  String? _productPrice;
  String? _productImg;
  int? _productCount;
  dynamic? _selectedAttr;
  int? _addTime;

  String? get id => _id;
  String? get orderId => _orderId;
  String? get productTitle => _productTitle;
  String? get productId => _productId;
  String? get productPrice => _productPrice;
  String? get productImg => _productImg;
  int? get productCount => _productCount;
  dynamic? get selectedAttr => _selectedAttr;
  int? get addTime => _addTime;

  ProductItem(
      {String? id,
      String? orderId,
      String? productTitle,
      String? productId,
      String? productPrice,
      String? productImg,
      int? productCount,
      dynamic? selectedAttr,
      int? addTime}) {
    _id = id;
    _orderId = orderId;
    _productTitle = productTitle;
    _productId = productId;
    _productPrice = productPrice;
    _productImg = productImg;
    _productCount = productCount;
    _selectedAttr = selectedAttr;
    _addTime = addTime;
  }

  ProductItem.fromJson(dynamic json) {
    _id = json["_id"];
    _orderId = json["order_id"];
    _productTitle = json["product_title"];
    _productId = json["product_id"];
    _productPrice = json["product_price"];
    _productImg = json["product_img"];
    _productCount = json["product_count"];
    _selectedAttr = json["selected_attr"];
    _addTime = json["add_time"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["order_id"] = _orderId;
    map["product_title"] = _productTitle;
    map["product_id"] = _productId;
    map["product_price"] = _productPrice;
    map["product_img"] = _productImg;
    map["product_count"] = _productCount;
    map["selected_attr"] = _selectedAttr;
    map["add_time"] = _addTime;
    return map;
  }
}
