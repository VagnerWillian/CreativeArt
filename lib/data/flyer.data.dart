/*
{
"id": "",
"title": "",
"src": "",
"price": 0.1,
"discount": [0,1],
"cupom": 0,
"category": "",
"views": 0.1,
"sell": 0.1,
"rate" : 0.1
}
*/
import 'package:creative_app/data/cupom.data.dart';
import 'package:creative_app/models/cupom.model.dart';
import 'package:flutter/material.dart';

class FlyerData {
  String _id;
  String _title;
  String _src;
  double _price;
  List<double> _discount;
  int _cupom;
  String _category;
  double _views;
  double _sell;
  double _rate;

  FlyerData(
      {String id,
        String title,
        String src,
        double price,
        List<double> discount,
        int cupom,
        String category,
        double views,
        double sell,
        double rate}) {
    this._id = id;
    this._title = title;
    this._src = src;
    this._price = price;
    this._discount = discount;
    this._cupom = cupom;
    this._category = category;
    this._views = views;
    this._sell = sell;
    this._rate = rate;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get title => _title;
  set title(String title) => _title = title;
  String get src => _src;
  set src(String src) => _src = src;
  double get price => _price;
  set price(double price) => _price = price;
  List<double> get discount => _discount;
  set discount(List<double> discount) => _discount = discount;
  int get cupom => _cupom;
  set cupom(int cupom) => _cupom = cupom;
  String get category => _category;
  set category(String category) => _category = category;
  double get views => _views;
  set views(double views) => _views = views;
  double get sell => _sell;
  set sell(double sell) => _sell = sell;
  double get rate => _rate;
  set rate(double rate) => _rate = rate;

  FlyerData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _src = json['src'];
    _price = json['price'];
    _discount = json['discount'].cast<double>();
    _cupom = json['cupom'];
    _category = json['category'];
    _views = json['views'];
    _sell = json['sell'];
    _rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['src'] = this._src;
    data['price'] = this._price;
    data['discount'] = this._discount;
    data['cupom'] = this._cupom;
    data['category'] = this._category;
    data['views'] = this._views;
    data['sell'] = this._sell;
    data['rate'] = this._rate;
    return data;
  }

/*

// EXEMPLO USANDO OS VALORES AMMOUT: 55 E PERCENT 100
  ApplyDiscount(double ammount, double percent){
    double ammountFinal = ammount - double.parse(((ammount / 100) * percent).toStringAsFixed(2));
    print("BUUUH=> DE ${ammount} para ${ammountFinal}");
  }
*/

  double finalPrice(){
    double ammountWithDiscount = 0;
    ammountWithDiscount = injectDescountInPercent();
    return num.parse(ammountWithDiscount.toStringAsFixed(2));
  }

  double injectDescountInPercent(){

    double ammountFinal = price;
    for(double x in discount){
      ammountFinal = (ammountFinal - ((ammountFinal / 100) * x)).toDouble();
    }
    return ammountFinal;
  }

  addDiscount({@required double percent}){
    if(percent != 0.0)
      discount = [percent];
  }

  addDiscountFromCupom(CupomData _cupomData,{Function onFailure, Function onSucess})async{

    CupomData cupomAsVerify = await CupomModel(_cupomData).verificaCupom();

    if(cupomAsVerify != null){

      double descountFromCupom = cupomAsVerify.porcent;
      discount.add(descountFromCupom);

      print("Descontos atuais ${discount}");
      print("Descontos atuais ${discount}");

      injectDescountInPercent();
      onSucess != null ? onSucess(cupomAsVerify) : null;
    }else{
      print("Cupom ${_cupomData.id} inválido, expirado ou já inserido");
      onFailure != null ? onFailure("Cupom inválido, expirado ou já inserido") : null;
    }
  }

  addView(){
    views != null ? views += 1 : views = 0;
    print("Visualizado + 1");
  }
}
