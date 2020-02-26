/*
{
"id": "",
"title": "",
"src": "",
"price": 0.5,
"discount": 0.5,
"category": ""
}
*/

class FlyerData {
  String _id;
  String _title;
  String _src;
  double _price;
  double _discount;
  String _category;

  FlyerData(
      {String id,
        String title,
        String src,
        double price,
        double discount,
        String category}) {
    this._id = id;
    this._title = title;
    this._src = src;
    this._price = price;
    this._discount = discount;
    this._category = category;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get src => _src;
  set src(String src) => _src = src;
  double get price => _price;
  set price(double price) => _price = price;
  double get discount => _discount;
  set discount(double discount) => _discount = discount;
  String get category => _category;
  set category(String category) => _category = category;

  FlyerData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _src = json['src'];
    _price = json['price'];
    _discount = json['discount'];
    _category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['src'] = this._src;
    data['price'] = this._price;
    data['discount'] = this._discount;
    data['category'] = this._category;
    return data;
  }
}
