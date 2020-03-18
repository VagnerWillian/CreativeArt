import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:creative_app/blocs/catalog_bloc.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/data/category.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:creative_app/screens/product.screen.dart';
import 'package:creative_app/tiles/catalog.item.tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
    final double itemWidth = size.width / 2.2;

    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                          if (scrollInfo.metrics.pixels > scrollInfo.metrics.maxScrollExtent-60) {
                           catalogBloc.loadFlyersFromCategory(categoryID: _list[tabController.index].id, increment: 2, scroll: (){});
                           // _loadData();
                          }
                        },
                        child: StaggeredGridView.countBuilder(
                          controller: _scrollController,
                          crossAxisCount: 4,
                          staggeredTileBuilder: (int index) =>
                          new StaggeredTile.count(2, index.isEven ? 3.8 : 3.8),
                          mainAxisSpacing: 6.0,
                          crossAxisSpacing: 6.0,
                          padding: EdgeInsets.all(0),
                          itemCount: snapshot.data[cat.id].length,
                          itemBuilder: (context, item) {
                            FlyerData _flyerData = snapshot.data[cat.id][item];
                            return CatalogTitleTile(flyerData: _flyerData, context: context);
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

  /*void scrollMore()async{
    _scrollController = ScrollController();
    print("SCROLLED ${_scrollController.position.maxScrollExtent-30}");
    await Future.delayed(Duration(seconds: 0));
    await _scrollController.animateTo(_scrollController.position.maxScrollExtent-60, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    _scrollController = null;
  }*/
}
