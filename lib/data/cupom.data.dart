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
  double _porcent;
  String _type;
  Timestamp _created;
  Timestamp _expire;

  CupomData(
      {String id}) {
    this._id = id;
  }

  String get id => _id;
  set id(String id) => _id = id;
  double get porcent => _porcent;
  set porcent(double percent) => _porcent = percent;
  String get type => _type;
  set type(String type) => _type = type;
  Timestamp get created => _created;
  set created(Timestamp created) => _created = created;
  Timestamp get expire => _expire;
  set expire(Timestamp expire) => _expire = expire;

  CupomData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _porcent = json['porcent'];
    _type = json['type'];
    _created = json['created'];
    _expire = json['expire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['porcent'] = this._porcent;
    data['type'] = this._type;
    data['created'] = this._created;
    data['expire'] = this._expire;
    return data;
  }
}
