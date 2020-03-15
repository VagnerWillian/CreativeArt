import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/blocs/catalog_bloc.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/components/catalog/catalog.grid.dart';
import 'package:creative_app/components/sliverapp/shopping.sliverapp.dart';
import 'package:creative_app/data/category.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:creative_app/data/user.data.dart';
import 'package:creative_app/models/fire.catalog.model.dart';
import 'package:creative_app/screens/login_signup.screen.dart';
import 'package:creative_app/screens/splash.screen.dart';
import 'package:creative_app/tabs/promotion.tab.dart';
import 'package:creative_app/tiles/title.tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShoppingTab extends StatefulWidget {

  TabController _tabController;
  ShoppingTab(this._tabController);

  @override
  _ShoppingTabState createState() => _ShoppingTabState(this._tabController);
}

class _ShoppingTabState extends State<ShoppingTab> with SingleTickerProviderStateMixin{

  TabController _tabController;
  _ShoppingTabState(this._tabController);

  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();
  final catalogBloc = BlocProvider.getBloc<CatalogBloc>();

  @override
  void initState() {
    super.initState();
  }

  loadFlyersFromCategory(_list){
    /*if(tabController.indexIsChanging){
      catalogBloc.loadFlyersFromCategory(categoryID: "FLRFlNoSk9Zn9kW0tKSj");
    }*/
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){},
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 170.0,

                forceElevated: true,
                actions: <Widget>[
                  Container(
                    width: 50,
                    child: RaisedButton(
                      onPressed: ()async{
                        await FireCatalogModel.addCatalogTestes();

                      },
                      onLongPress: ()async{
                        await FireCatalogModel.deleteAllCatalogTestes();
                      },
                      child: Icon(
                        FontAwesomeIcons.shoppingBag,
                        color: Colors.white,
                        size: 16,
                      ),
                      elevation: 0,
                      color: Colors.transparent,
                    ),
                  ),
                  Container(
                    width: 50,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                loginAndRegisterBloc.signOut();
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => LoginAndSignUpScreen()));
                              },
                              child: Icon(
                                FontAwesomeIcons.solidBell,
                                color: Colors.white,
                                size: 20,
                              )),
                          Container(
                            alignment: Alignment.topRight,
                            width: 13,
                            height: 13,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ), //CircleAvatar(backgroundColor: Colors.red, child: Text("•", style: TextStyle(fontSize: 13),textAlign: TextAlign.center,),),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
                floating: false,
                pinned: true,
                backgroundColor: Color.fromRGBO(38, 39, 46, 1),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: GestureDetector(
                        onTap: (){
                          FireCatalogModel.addCatalogTestes();
                        },
                        onLongPress: (){
                          FireCatalogModel.deleteAllCatalogTestes();
                        },
                        child: TitleTile()),
                    background: StreamBuilder<UserData>(
                        stream: loginAndRegisterBloc.getUser,
                        initialData: loginAndRegisterBloc.actuallyUser,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Container(
                                child: OutlineButton(onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginAndSignUpScreen()));
                                },
                                  color: Colors.green,
                                  borderSide: BorderSide(color: Colors.greenAccent),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                  child: Text("Entrar ou Criar uma conta", style: TextStyle(color: Colors.greenAccent),),
                                ),
                              ),
                            );
                          } else {
                            return SliverAppShopping(snapshot.data);
                          }
                        })),
              ),
            ];
          },
          body: Material(
            child: Container(
                color: Color.fromRGBO(25, 26, 31, 1),
                child: Column(
                  children: <Widget>[
                    StreamBuilder<UserData>(
                        stream: loginAndRegisterBloc.getUser,
                        initialData: loginAndRegisterBloc.actuallyUser,
                        builder: (context, snapshot) {
                          if(!snapshot.hasData){
                            return Container();
                          }else{
                            return Container(
                              height: 80,
                              padding: EdgeInsets.all(8),
                              color: Colors.green, //Color.fromRGBO(38, 39, 46,1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.promotionId,
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Indique e ganhe R\$5",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      _tabController.animateTo(1);
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>PromotionTab(_tabController)));
                                    },
                                    child: Text(
                                      "Saiba mais",
                                      style: TextStyle(color: Colors.black, fontSize: 13),
                                    ),
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                                  )
                                ],
                              ),
                            );
                          }
                        }
                    ),
                    FutureBuilder<List<CategoryData>>(
                      future: catalogBloc.loadCategories(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Column(
                            children: <Widget>[
                              Container(
                                // width: 30,
                                  height: 3,
                                  child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),backgroundColor: Colors.black38,)
                              ),
                            ],
                          );
                        }else{
                          return CatalogGrid(snapshot.data);
                        }
                      }
                    ),
                  ],
                )),
          ),
      ),
    );
  }
}
