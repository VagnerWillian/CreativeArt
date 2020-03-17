import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:creative_app/blocs/catalog_bloc.dart';
import 'package:creative_app/data/category.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:creative_app/menus/menu.shop.dart';
import '../tests/catalog.tester.dart';
import 'package:creative_app/tabs/promotion.tab.dart';
import 'package:creative_app/tabs/shopping.tabs.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final catalogBloc = BlocProvider.getBloc<CatalogBloc>();


  @override
  Future<void> initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerShop(_tabController),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: <Widget>[
          ShoppingTab(_tabController),
          WillPopScope(
              onWillPop: (){
                _tabController.animateTo(0);
              },
              child: PromotionTab(_tabController)),
          WillPopScope(
              onWillPop: (){
                _tabController.animateTo(0);
              },
              child: Container())
        ],
      ));
  }
}
