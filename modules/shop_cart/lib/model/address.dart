/// _id : "60c038ddf8a1570f48535dfb"
/// uid : "60b9d74af98bbd1004bb6208"
/// name : "zhangsan"
/// phone : "123456789"
/// address : "北京市北京城区东城区 asdfads"
/// default_address : 1
/// status : 1
/// add_time : 1623210205593

class Address {
  String? _id;
  String? _uid;
  String? _name;
  String? _phone;
  String? _address;
  String? _area;
  String? _detailAddress;
  int? _defaultAddress;
  int? _status;
  int? _addTime;

  String? get id => _id;
  String? get uid => _uid;
  String? get name => _name;
  String? get phone => _phone;
  String? get address => _address;
  int? get defaultAddress => _defaultAddress;
  int? get status => _status;
  int? get addTime => _addTime;

  String? get area => _area;

  set id(String? value) {
    _id = value;
  }

  Address(
      {String? id,
      String? uid,
      String? name,
      String? phone,
      String? address,
      int? defaultAddress,
      int? status,
      int? addTime}) {
    _id = id;
    _uid = uid;
    _name = name;
    _phone = phone;
    _address = address;
    _defaultAddress = defaultAddress;
    _status = status;
    _addTime = addTime;
  }

  Address.fromJson(dynamic json) {
    _id = json["_id"];
    _uid = json["uid"];
    _name = json["name"];
    _phone = json["phone"];
    _address = json["address"];
    _defaultAddress = json["default_address"];
    _status = json["status"];
    _addTime = json["add_time"];
    if (_address != null && _address!.contains(" ")) {
      _area = _address!.split(" ")[0];
      _detailAddress = _address!.split(" ")[1];
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = _id;
    map["uid"] = _uid;
    map["name"] = _name;
    map["phone"] = _phone;
    map["address"] = _address;
    map["default_address"] = _defaultAddress;
    map["status"] = _status;
    map["add_time"] = _addTime;
    map["area"] = _area;
    map["detailAddress"] = _address;
    return map;
  }

  String? get detailAddress => _detailAddress;

  set uid(String? value) {
    _uid = value;
  }

  set name(String? value) {
    _name = value;
  }

  set phone(String? value) {
    _phone = value;
  }

  set address(String? value) {
    _address = value;
  }

  set area(String? value) {
    _area = value;
  }

  set detailAddress(String? value) {
    _detailAddress = value;
  }

  set defaultAddress(int? value) {
    _defaultAddress = value;
  }

  set status(int? value) {
    _status = value;
  }

  set addTime(int? value) {
    _addTime = value;
  }
}
