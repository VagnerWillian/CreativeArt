class GeralData {
  List<dynamic> _isMaintenance;
  int _discountGeral;

  GeralData({List<dynamic> isMaintenance, int discountGeral}) {
    this._isMaintenance = isMaintenance;
    this._discountGeral = discountGeral;
  }

  List<dynamic> get isMaintenance => _isMaintenance;
  set isMaintenance(List<dynamic> isMaintenance) => _isMaintenance = isMaintenance;
  int get discountGeral => _discountGeral;
  set discountGeral(int discountGeral) => _discountGeral = discountGeral;

  GeralData.fromJson(Map<String, dynamic> json) {
    _isMaintenance = json['isMaintenance'].cast<dynamic>();
    _discountGeral = json['discountGeral'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isMaintenance'] = this._isMaintenance;
    data['discountGeral'] = this._discountGeral;
    return data;
  }
}
