class GeralData {
  List<dynamic> _isMaintenance;
  Map<String, dynamic> _discountGeral;

  GeralData({List<dynamic> isMaintenance, Map<String, dynamic> discountGeral}) {
    this._isMaintenance = isMaintenance;
    this._discountGeral = discountGeral;
  }

  List<dynamic> get isMaintenance => _isMaintenance;
  set isMaintenance(List<dynamic> isMaintenance) => _isMaintenance = isMaintenance;
  Map<String, dynamic> get discountGeral => _discountGeral;
  set discountGeral(Map<String, dynamic> discountGeral) => _discountGeral = discountGeral;

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
