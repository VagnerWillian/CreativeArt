import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/components/sliverapp/shopping.sliverapp.dart';
import 'package:creative_app/data/user.data.dart';
import 'package:creative_app/menus/menu.shop.dart';
import 'package:creative_app/screens/login.signup_screen.dart';
import 'package:creative_app/screens/splash_screen.dart';
import 'package:creative_app/tabs/shopping.tabs.dart';
import 'package:creative_app/tiles/title.tile.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          ShoppingTab(),
          Container()
        ],
      ));
  }
}
