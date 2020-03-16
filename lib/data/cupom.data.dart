import 'package:cloud_firestore/cloud_firestore.dart';

/*
{
"id": "",
"percent": 0,
"type": "",
"created": "dd/MM/yyyy",
"expire": "00/00/0000"
}
*/

class CupomData {
  String _id;
  double _percent;
  String _type;
  Timestamp _created;
  Timestamp _expire;

  CupomData(
      {String id}) {
    this._id = id;
  }

  String get id => _id;
  set id(String id) => _id = id;
  double get percent => _percent;
  set percent(double percent) => _percent = percent;
  String get type => _type;
  set type(String type) => _type = type;
  Timestamp get created => _created;
  set created(Timestamp created) => _created = created;
  Timestamp get expire => _expire;
  set expire(Timestamp expire) => _expire = expire;

  CupomData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _percent = json['percent'];
    _type = json['type'];
    _created = json['created'];
    _expire = json['expire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['percent'] = this._percent;
    data['type'] = this._type;
    data['created'] = this._created;
    data['expire'] = this._expire;
    return data;
  }
}
