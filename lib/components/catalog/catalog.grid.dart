import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/blocs/catalog_bloc.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/data/category.flyter.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:flutter/material.dart';

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
  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();
  final catalogBloc = BlocProvider.getBloc<CatalogBloc>();


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: _list.length, vsync: this);
    tabController.addListener(listCat);
  }

  void listCat(){
    catalogBloc.loadFlyersFromCategory(categoryID: _list[tabController.index].id);
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
            child: TabBarView(
                controller: tabController,
                children: _list.map((listFlyer){
                  return StreamBuilder<List<FlyerData>>(
                      stream: catalogBloc.getCatalogList,
                      //initialData: [FlyerData(id: "033MM3tj62", title: "Mega Conferência", category: "FFQIsuNwEHOCyYxVmE5X", discount: 20, price: 20.50, src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/84142527_2303100296654701_2488372127086936064_o.jpg?_nc_cat=109&_nc_ohc=0gjqxFZwtQ4AX-MJo5G&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=bf2075e27c1fbd90443704cd27e9f8d3&oe=5EFF20DF")],
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return Center(
                            child: Container(
                              width: 200,
                              height: 200,
                              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),
                            ),
                          );
                        }else{
                          return GridView.builder(
                            padding: EdgeInsets.all(1),
                            itemCount: snapshot.data.length,
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
                                    Flexible(child: CachedNetworkImage(imageUrl: snapshot.data[item].src)),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.all(5),
                                            child: Text(
                                              snapshot.data[item].title,
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
                                                onPressed: () {},
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
                          );
                        }
                      }
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
