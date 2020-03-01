import 'package:creative_app/components/catalog/catalog.grid.dart';
import 'package:flutter/material.dart';

class PromotionTab extends StatefulWidget {
  @override
  _PromotionTabState createState() => _PromotionTabState();
}

class _PromotionTabState extends State<PromotionTab> {
  @override
  Widget build(BuildContext context) {

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 170.0,
            forceElevated: true,
            floating: false,
            pinned: true,
            backgroundColor: Color.fromRGBO(38, 39, 46, 1),
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Promova e ganhe", style: TextStyle(fontSize: 11),),
                background: Container(
                  color: Colors.green,
                )),
          ),
        ];
      },
      body: Container()
    );
  }
}
