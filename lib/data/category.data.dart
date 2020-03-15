/*
{
"id": "",
"title": ""
}
*/

class CategoryData {
  String _id;
  String _title;

  CategoryData({String id, String title}) {
    this._id = id;
    this._title = title;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;

  CategoryData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    return data;
  }
}
