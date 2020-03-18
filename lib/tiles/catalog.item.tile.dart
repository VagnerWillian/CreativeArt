import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:creative_app/dialogs/preview.flyer.dialog.dart';
import 'package:creative_app/models/validators.forms.dart';
import 'package:creative_app/screens/product.screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget CatalogTitleTile({@required FlyerData flyerData, @required context}) {
  FlyerData _flyerData = flyerData;

  if (_flyerData == null) {
    return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white24),
        ));
  }


  return Container(
    margin: EdgeInsets.all(5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: CachedNetworkImage(
                    height: 260,
                    fit: BoxFit.cover,
                    imageUrl: _flyerData.src,
                    placeholder: (context, str) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white24),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned.fill(
                child: new Material(
                    color: Colors.transparent,
                    child: new InkWell(
                      splashColor: Colors.black12,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return PreviewFlyer.previewDialog(src: _flyerData.src);
                            });
                      },
                    ))),
            /* Positioned(
              top: 5,
              right: -12,
              child: Transform.rotate(
                angle: - 3.14 / -8.0,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
                      color: Colors.yellow[800]
                  ),
                  child: Center(
                    child: Text("-${_flyerData.discount[0]['typeDiscount'] == "%"
                        ? "${_flyerData.discount[0]['discount'].round()}%"
                        : "R\$${_flyerData.discount[0]['discount'].round()}"}OFF", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 11),),
                  ),
                ),
              ),
            )*/
          ],
        ),
        Container(
            margin: EdgeInsets.all(5),
            child: Text(
              _flyerData.title,
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        RatingBar(
          unratedColor: Colors.grey[600],
          initialRating: flyerData.rate,
          minRating: 1,
          itemSize: 20,
          ignoreGestures: true,
          glowColor: Colors.yellow[800],
          direction: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.yellow[800],
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    flyerData.price == flyerData.finalPrice() ? Container() : Text(
                      "de: ${Validators.convertToReal(flyerData.price)}",
                      style: TextStyle(color: Colors.yellow[800], fontSize: 17),
                    ),
                    Positioned(
                      left: 25,
                      child: Container(
                          width: 85,
                          height: 20,
                          child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:
                              "https://i.ya-webdesign.com/images/cross-icon-png-6.png")),
                    )
                  ],
                ),
                Text(
                  "por: ${Validators.convertToReal(flyerData.finalPrice())}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 75,
              child: RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(_flyerData)));
                },
                color: Colors.green,
                child: //Icon(Icons.shopping_cart, color: Colors.white, size: 19,)
                Text(
                  "QUERO!",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
