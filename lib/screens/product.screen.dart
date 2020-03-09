import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductScreen extends StatefulWidget {
  FlyerData _flyerData;

  ProductScreen(this._flyerData);

  @override
  _ProductScreenState createState() => _ProductScreenState(this._flyerData);
}

class _ProductScreenState extends State<ProductScreen> {
  FlyerData _flyerData;

  _ProductScreenState(this._flyerData);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          /* SliverAppBar(
            //expandedHeight: 170.0,
            forceElevated: true,
            actions: <Widget>[
              Container(
                width: 70,
                child: RaisedButton(onPressed: (){},
                color: Colors.transparent,
                elevation: 0,
                child: Icon(Icons.favorite_border, color: Colors.white,),
                ),
              )
            ],
            floating: false,
            pinned: true,
            backgroundColor: Color.fromRGBO(38, 39, 46, 1),
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(_flyerData.title, style: TextStyle(fontSize: 12),),
                //background: ),
          )),*/
        ];
      },
      body: Material(
        child: Container(
          color: Color.fromRGBO(25, 26, 31, 1),
          child: Stack(
            children: <Widget>[

           /*   PageView(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  )
                ],
              ),*/
              Container(
                color: Color.fromRGBO(38, 39, 46, 1),
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 300,
                      child: CachedNetworkImage(
                        imageUrl: _flyerData.src,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 140),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)]),
                              height: 300,
                              child: CachedNetworkImage(imageUrl: _flyerData.src)
                          ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(onPressed: (){},
                            color: Colors.green,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            child: Text("Visualizar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                          SizedBox(width: 10,),
                          OutlineButton(onPressed: (){},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            borderSide: BorderSide(color: Colors.white,),
                            child: Icon(FontAwesomeIcons.shareAlt, color: Colors.white,),
                          ),
                        ],
                      ),
                    /*      Container(
                            width: 200,
                            height: 300,
                            color: Color.fromRGBO(38, 39, 46, 1),
                          )*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70),
                alignment: Alignment.topCenter,
                child: Text(
                  _flyerData.title,
                  style: TextStyle(
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 8.0,
                        color: Color.fromARGB(125, 0, 0, 255),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 55,
                    //margin: EdgeInsets.all(15),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.green,
                      child: Text(
                        "Comprar agora",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
