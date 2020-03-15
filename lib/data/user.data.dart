/*
{
  "uid" : "",
  "name" : "",
  "avatar" : "",
  "whatsapp" : "",
  "email" : "",
  "promotionId" : "",
  "indicateFrom" : "",
  "myWallet" : 0.1
}
*/
class UserData {
  String _uid;
  String _name;
  String _avatar;
  String _whatsapp;
  String _email;
  String _promotionId;
  String _indicateFrom;
  double _myWallet;

  UserData(
      {String uid,
        String name,
        String avatar,
        String whatsapp,
        String email,
        String promotionId,
        String indicateFrom,
        double myWallet}) {
    this._uid = uid;
    this._name = name;
    this._avatar = avatar;
    this._whatsapp = whatsapp;
    this._email = email;
    this._promotionId = promotionId;
    this._indicateFrom = indicateFrom;
    this._myWallet = myWallet;
  }

  String get uid => _uid;
  set uid(String uid) => _uid = uid;
  String get name => _name;
  set name(String name) => _name = name;
  String get avatar => _avatar;
  set avatar(String avatar) => _avatar = avatar;
  String get whatsapp => _whatsapp;
  set whatsapp(String whatsapp) => _whatsapp = whatsapp;
  String get email => _email;
  set email(String email) => _email = email;
  String get promotionId => _promotionId;
  set promotionId(String promotionId) => _promotionId = promotionId;
  String get indicateFrom => _indicateFrom;
  set indicateFrom(String indicateFrom) => _indicateFrom = indicateFrom;
  double get myWallet => _myWallet;
  set myWallet(double myWallet) => _myWallet = myWallet;

  UserData.fromJson(Map<String, dynamic> json) {
    _uid = json['uid'];
    _name = json['name'];
    _avatar = json['avatar'];
    _whatsapp = json['whatsapp'];
    _email = json['email'];
    _promotionId = json['promotionId'];
    _indicateFrom = json['indicateFrom'];
    _myWallet = json['myWallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this._uid;
    data['name'] = this._name;
    data['avatar'] = this._avatar;
    data['whatsapp'] = this._whatsapp;
    data['email'] = this._email;
    data['promotionId'] = this._promotionId;
    data['indicateFrom'] = this._indicateFrom;
    data['myWallet'] = this._myWallet;
    return data;
  }
}
