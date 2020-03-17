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
  List<Map<String, dynamic>> _discount = [];
  String _category;
  double _views;
  double _sell;
  double _rate;

  FlyerData(
      {String id,
        String title,
        String src,
        double price,
        List<Map<String, dynamic>> discount,
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
  List<Map<String, dynamic>> get discount => _discount;
  set discount(List<Map<String, dynamic>> discount) => _discount = discount;
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
    for(Map<String,dynamic> x in json['discount']){
      _discount.add(x);
    }
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
    ammountWithDiscount = priceFinalWithDescounts();
    return num.parse(ammountWithDiscount.toStringAsFixed(2));
  }

  addDiscountGeral({@required Map<String, dynamic> discountGeral}){
    if(!discountGeral.isEmpty)
      discount = [discountGeral];
  }

  addDiscountFromCupom(CupomData _cupomData,{Function onFailure, Function onSucess})async{

    CupomData cupomAsVerify = await CupomModel(_cupomData).verificaCupom();

    if(cupomAsVerify != null){

      Map<String, dynamic> descountFromCupom = cupomAsVerify.discount;
      discount.add(descountFromCupom);

      priceFinalWithDescounts();
      print("Descontos atuais ${discount}");

      onSucess != null ? onSucess(cupomAsVerify) : null;

    }else{
      onFailure != null ? onFailure("Cupom inválido, expirado ou já inserido") : null;
    }
  }

  double priceFinalWithDescounts(){
    double ammoutFinalWithDiscounts = price;
    for(Map<String, dynamic> discount in discount){
      if(discount['typeDiscount'] == "%"){
        ammoutFinalWithDiscounts = (ammoutFinalWithDiscounts - ((ammoutFinalWithDiscounts / 100) * discount['discount'])).toDouble();
      }else if(discount['typeDiscount'] == "\$"){
        ammoutFinalWithDiscounts = ammoutFinalWithDiscounts - discount['discount'];
      }
    }
    if(ammoutFinalWithDiscounts <= 0){
      ammoutFinalWithDiscounts = 0;
      print("****** O DESCONTO APLICADO É MAIOR DO QUE O VALOR DO PRODUTO");
    }
    return ammoutFinalWithDiscounts;
  }

  addView(){
    views != null ? views += 1 : views = 0;
    print("Visualizado + 1");
  }
}
