import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/blocs/catalog_bloc.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/data/category.flyter.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:creative_app/screens/product.screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CatalogGrid extends StatefulWidget {
  List<CategoryData> _list;
  CatalogGrid(this._list);

  @override
  _CatalogGridState createState() => _CatalogGridState(this._list);
}

class _CatalogGridState extends State<CatalogGrid> with SingleTickerProviderStateMixin{
  List<CategoryData> _list;
  _CatalogGridState(this._list);

  TabController tabController;
  ScrollController _scrollController;

  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();
  final catalogBloc = BlocProvider.getBloc<CatalogBloc>();


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _list.length, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 3;
    final double itemWidth = size.width / 2.47;

    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              indicator: new BubbleTabIndicator(
                indicatorHeight: 30.0,
                indicatorColor: Colors.purple,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              tabs: _list.map((cat){
                return Text(cat.title, style: TextStyle(fontSize: 13),);
              }).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<Map<String, dynamic>>(
              stream: catalogBloc.getCatalogList,
              initialData: catalogBloc.actuallyListCatalog,
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
                  return TabBarView(
                    controller: tabController,
                    children: _list.map((cat){
                      if(snapshot.data[cat.id] == null){
                        return Column(
                          children: <Widget>[
                            Container(
                              // width: 30,
                                height: 3,
                                child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),backgroundColor: Colors.black38,)
                            ),
                          ],
                        );
                      }
                      return NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                            catalogBloc.loadFlyersFromCategory(categoryID: _list[tabController.index].id, increment: snapshot.data[cat.id].length + 2);
                           // _loadData();
                          }
                        },
                        child: GridView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.all(1),
                          itemCount: snapshot.data[cat.id].length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: (itemWidth / itemHeight),
                          ),
                          itemBuilder: (context, item) {

                            FlyerData _flyerData = snapshot.data[cat.id][item];

                            return Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                //color: Colors.white10,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Flexible(child: CachedNetworkImage(imageUrl: _flyerData.src,
                                    placeholder: (context, str){
                                      return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white24),),);
                                    },
                                  )),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.all(5),
                                          child: Text(
                                            _flyerData.title,
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
                                                "por: R\$ ${_flyerData.price}",
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
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                }
              }
            ))
        ],
      ),
    );
  }
}
