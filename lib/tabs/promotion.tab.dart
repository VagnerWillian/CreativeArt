import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/components/catalog/catalog.grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PromotionTab extends StatefulWidget {
  TabController _tabController;

  PromotionTab(this._tabController);

  @override
  _PromotionTabState createState() => _PromotionTabState(this._tabController);
}

class _PromotionTabState extends State<PromotionTab> {
  TabController _tabController;

  _PromotionTabState(this._tabController);

  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: RaisedButton(
                  onPressed: (){
                    _tabController.animateTo(0);
                  },
                  color: Colors.transparent,
                  elevation: 0,
                  child: Icon(Icons.arrow_back, color: Colors.white,),
                ),
                actions: <Widget>[
                  RaisedButton(onPressed: (){},
                  elevation: 0,
                  color: Colors.transparent,
                  child: Icon(Icons.help_outline, color: Colors.white,),
                  )
                ],
                expandedHeight: 250.0,
                forceElevated: true,
                floating: false,
                pinned: true,
                backgroundColor: Color.fromRGBO(38, 39, 46, 1),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Text("Saldo atual: R\$5,00", style: TextStyle(color: Colors.white, fontSize: 11),),
                        ),
                        /*RaisedButton(
                        onPressed: (){},
                          color: Colors.transparent,
                          elevation: 0,
                        child: Icon(Icons.help_outline, color: Colors.white,),
                        )*/
                      ],
                    ),
                    background: Container(
                      color: Colors.green,
                      child: Center(
                          child: Container(
                            padding: EdgeInsets.all(70),
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Compartilhe o código abaixo com seus amigos e ganhe R\$5 para comprar cartazes.", textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 50,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.white)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      loginAndRegisterBloc.actuallyUser.promotionId,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  )),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 60,
                                        child: RaisedButton(
                                          elevation: 0,
                                          onPressed: () {
                                            Clipboard.setData(ClipboardData(text: loginAndRegisterBloc.actuallyUser.promotionId));
                                          },
                                          color: Colors.white10,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(100), topRight: Radius.circular(100))),
                                          child: Icon(FontAwesomeIcons.copy, color: Colors.white,),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                    )),
              ),
            ];
          },
          body: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, item){
              return  Container(
                color: item % 2 == 0 ? Color.fromRGBO(38, 39, 46,1): Color.fromRGBO(25, 26, 31,1),
                height: 80,
              );
            },
          )),
    );
  }
}
