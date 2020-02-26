import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/data/user.data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

Widget SliverAppShopping(UserData userData) {
  double myWallet = double.tryParse(userData.myWallet.toString());
  MoneyFormatterOutput wallet = FlutterMoneyFormatter(
      amount: myWallet,
      settings: MoneyFormatterSettings(
        decimalSeparator: ",",
        thousandSeparator: ".",
        symbol: "R\$",
      )
  ).output;
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: CachedNetworkImageProvider(userData.avatar), fit: BoxFit.cover)
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 25,
              child: RaisedButton(onPressed: () {},
                color: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(100),
                        topRight: Radius.circular(100), bottomRight: Radius.circular(100))
                ),
                child: Text("${userData.name.split(' ')[0]} ${userData.name.split(' ')[1]}", style: TextStyle(color: Colors.white, fontSize: 10),),
              ),
            ),
            Container(
              height: 25, width: 100,
              child: OutlineButton(onPressed: () {},
                color: Colors.transparent,
                borderSide: BorderSide(color: Colors.greenAccent),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Text(myWallet > 9999.9 ? wallet.compactSymbolOnLeft : wallet.symbolOnLeft.toString(),
                  style: TextStyle(color: Colors.greenAccent, fontSize: 10),),
              ),
            )
          ],
        )
      ],
    ),
  );
}