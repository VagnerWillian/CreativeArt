class UserData {
  String _uid;
  String _name;
  String _avatar;
  String _whatsApp;
  String _email;
  String _promotionId;
  var _myWallet;

  UserData(
      {
        String name,
        String uid,
        String avatar,
        String whatsApp,
        String email,
        String promotionId,
        var myWallet}) {
    this._name = name;
    this._uid = uid;
    this._avatar = avatar;
    this._whatsApp = whatsApp;
    this._email = email;
    this._promotionId = promotionId;
    this._myWallet = myWallet;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get uid => _uid;
  set uid(String uid) => _uid = uid;
  String get avatar => _avatar;
  set avatar(String avatar) => _avatar = avatar;
  String get whatsApp => _whatsApp;
  set whatsApp(String whatsApp) => _whatsApp = whatsApp;
  String get email => _email;
  set email(String email) => _email = email;
  String get promotionId => _promotionId;
  set promotionId(String promotionId) => _promotionId = promotionId;
  get myWallet => _myWallet;
  set myWallet(var myWallet) => _myWallet = myWallet;

  UserData.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _uid = json['id'];
    _avatar = json['avatar'];
    _whatsApp = json['whatsApp'];
    _email = json['email'];
    _promotionId = json['promotionId'];
    _myWallet = json['myWallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['id'] = this._uid;
    data['avatar'] = this._avatar;
    data['whatsApp'] = this._whatsApp;
    data['email'] = this._email;
    data['promotionId'] = this._promotionId;
    data['myWallet'] = this._myWallet;
    return data;
  }
}
