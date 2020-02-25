import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/components/sliverapp/shopping.sliverapp.dart';
import 'package:creative_app/data/user.data.dart';
import 'package:creative_app/screens/login.signup_screen.dart';
import 'package:creative_app/screens/splash_screen.dart';
import 'package:creative_app/tiles/title.tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShoppingTab extends StatefulWidget {
  @override
  _ShoppingTabState createState() => _ShoppingTabState();
}

class _ShoppingTabState extends State<ShoppingTab> with SingleTickerProviderStateMixin{

  TabController tabController;
  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2.47;

    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 170.0,
              leading: RaisedButton(
                onPressed: () async {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(
                  FontAwesomeIcons.bars,
                  color: Colors.white,
                  size: 16,
                ),
                elevation: 0,
                color: Colors.transparent,
              ),
              forceElevated: true,
              actions: <Widget>[
                Container(
                  width: 50,
                  child: RaisedButton(
                    onPressed: () {},
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
                  title: TitleTile(),
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
                                  onPressed: () {},
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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TabBar(
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: new BubbleTabIndicator(
                        indicatorHeight: 30.0,
                        indicatorColor: Colors.purple,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                      tabs: <Widget>[
                        Text("Congressos"),
                        Text("Vigílias"),
                        Text("Ministerial"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        GridView.builder(
                          padding: EdgeInsets.all(1),
                          itemCount: 6,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: (itemWidth / itemHeight),
                          ),
                          itemBuilder: (context, item) {
                            return Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //color: Colors.white10,
                              ),
                              child: Column(
                                children: <Widget>[
                                  CachedNetworkImage(imageUrl: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/81742038_2277845419180"
                                      "189_1061110342362333184_o.jpg?_nc_cat=109&_nc_ohc=X6YSewbs_yAAX8VSCc3&_nc_ht=scontent.fcgh2-1.fna&_nc_tp="
                                      "7&oh=ef00859a037957045a38196fb70b4f55&oe=5EBB3908"),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          child: Text(
                                            "Teste",
                                            style: TextStyle(color: Colors.grey),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Stack(
                                                children: <Widget>[
                                                  Text(
                                                    "de: R\$ 89,90",
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
                                                "por: R\$ 49,99",
                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                              onPressed: () {},
                                              color: Colors.green,
                                              child: //Icon(Icons.shopping_cart, color: Colors.white, size: 19,)
                                              Text(
                                                "QUERO!",
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Container(),
                        Container()
                      ],
                    ),
                  ),
                ],
              )),
        ),
    );
  }
}
