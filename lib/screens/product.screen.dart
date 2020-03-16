import 'dart:ui';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/blocs/catalog_bloc.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/data/cupom.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:creative_app/dialogs/preview.flyer.dialog.dart';
import 'package:creative_app/models/cupom.model.dart';
import 'package:creative_app/models/fire.catalog.model.dart';
import 'package:creative_app/models/validators.forms.dart';
import 'package:creative_app/tiles/analytics.product.tile.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

    final catalogBloc = BlocProvider.getBloc<CatalogBloc>();

    catalogBloc.addViewFlyer(_flyerData);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
            Top(),
            Body(),
           // Bottom()
        ],
        ),
      ),
    );
  }

  Widget Top(){
    return Container(
      height: 420,
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)]),
                  height: 350,
                  child: Stack(
                    children: <Widget>[
                      CachedNetworkImage(imageUrl: _flyerData.src,
                        placeholder: (context, str){
                          return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white24),),);
                        },
                      ),
                      Positioned.fill(
                          child: new Material(
                              color: Colors.transparent,
                              child: new InkWell(
                                splashColor: Colors.black12,
                                onTap: (){
                                  showDialog(context: context,
                                      builder: (context){
                                        return PreviewFlyer.previewDialog(src: _flyerData.src);
                                      }
                                  );
                                },
                              ))),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Body(){
    final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();

    Map<String, dynamic> oneStep = {
      "title": "Pagamento",
      "subtitle": "Após escolher o cartaz que você mais gostou, basta clicar em COMPRAR AGORA e "
                  "selecionar o melhor método de pagamento pra você. Aceitamos Boleto e Cartão de Crédito",
    };

    Map<String, dynamic> twoStep = {
      "title": "Envio de informações",
      "subtitle": "Se o pagamento for aprovado, você será direcionado para uma tela onde você"
          "preencherá todas as informações que incluiremos no cartaz.",
    };

    Map<String, dynamic> threeStep = {
      "title": "Produção",
      "subtitle": "Depois de fazer o pagamento, você será direcionado para a sua lista de"
          "pedidos. Nessa fase é SÓ AGUARDAR que avisaremos quando os eu cartaz estiver pronto",
    };

    Map<String, dynamic> fourStep = {
      "title": "Entrega",
      "subtitle": "Pronto, no seu pedido terá um botão pra você baixar o seu cartaz e compartilhar"
                  " nas redes socials",
    };

    List<dynamic> steps = [0, oneStep, twoStep, threeStep, fourStep];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InfoPrices(_flyerData),
        Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnalyticsBar.AnalyticBar(value: _flyerData.views , icon: FontAwesomeIcons.eye, title: "Visualizações"),
                  AnalyticsBar.AnalyticBar(value: _flyerData.sell, icon: FontAwesomeIcons.check, title: "Vendidos"),
                  Stack(
                    children: <Widget>[
                      AnalyticsBar.AnalyticBar(value: 0, icon: FontAwesomeIcons.comment, title: "Comentarios"),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(child: Text("Breve", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9),),
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.yellow[800])
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        Column(
          children: <Widget>[
            Text("Avaliação média:", style: TextStyle(color: Colors.grey),),
            RatingBar(
              unratedColor: Colors.grey[600],
              initialRating: _flyerData.rate,
              minRating: 1,
              itemSize: 35,
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.yellow[800],
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              padding: EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  FireCatalogModel.comprar(_flyerData, loginAndRegisterBloc.actuallyUser.uid);
                },
                color: Colors.green,
                child: Text(
                  "Comprar agora",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: steps.length,
          itemBuilder: (context, item){
            if(item != 0){
              return Container(
                margin: EdgeInsets.all(5),
                child: ListTile(
                  leading: Container(
                    width: 30,
                    height: 30,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.purple, width: 2)
                      ),
                      child: Center(child: Text(item.toString(), style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                  title: Text(steps[item]['title'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  subtitle: Text(steps[item]['subtitle'], style: TextStyle(color: Colors.grey),),
                ),
              );
            }else{
              return Container();
            }

          },
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Text("Formas de pagamento", style: TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold),),
              SizedBox(height: 40,
              child: Icon(Icons.arrow_drop_down, color: Colors.purpleAccent,),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 70,
                    child: Column(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.barcode, color: Colors.white, size: 70,),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 70,
                    child: Column(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.solidCreditCard, color: Colors.white, size: 60,),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(" • Boleto \n • Cartão de Crédito \n • Depôsito Bancário \n • Transferência Bancária", style: TextStyle(color: Colors.white),textAlign: TextAlign.start,),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget Bottom(){
    return Container(
      height: 55,
      margin: EdgeInsets.only(top: 30),
      child: RaisedButton(
        onPressed: () {
          //FireCatalogModel.comprar(_flyerData, loginAndRegisterBloc.actuallyUser.uid);
        },
        color: Colors.green,
        child: Text(
          "Comprar agora",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class InfoPrices extends StatefulWidget {

  FlyerData _flyerData;

  InfoPrices(this._flyerData);

  @override
  _InfoPricesState createState() => _InfoPricesState(this._flyerData);
}

class _InfoPricesState extends State<InfoPrices> {

  FlyerData _flyerData;
  TextEditingController _cupomCotroller = TextEditingController(text: "GOSPELMENTE");
  CupomData _cupom;

  _InfoPricesState(this._flyerData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: RaisedButton(onPressed: (){},
                color: Colors.yellow[800],
                child: Text(Validators.convertToReal(_flyerData.finalPrice()), style: TextStyle(color: Colors.white),),
              ),
            ),

            Container(
              height: 35,
              child: DottedBorder(
                color: Colors.yellow[800],
                child: OutlineButton(
                  onPressed: (){
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context){
                        return Dialog(
                          child: Container(
                            height: 200,
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    controller: _cupomCotroller,
                                  ),
                                  RaisedButton(onPressed: ()async{
                                    CupomData _verifyCupom = CupomData(id: _cupomCotroller.text.toUpperCase());
                                    if(_cupom == null){
                                      await _flyerData.addDiscountFromCupom(_verifyCupom, onFailure: onFailure, onSucess: onSucess);
                                      setState(() {});
                                    }else{
                                      onFailure("Um cupom já foi inserido");
                                    }

                                  },
                                  child: Text("Verificar"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                  );
                },
                  color: Colors.black26,
                  child: Text(setCupom(), style: TextStyle(color: Colors.yellow[800]),),
                ),
              ),
            ),
          ],
        ),
        Text("*Desconto % já aplicado", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),),


      ],
    );
  }


  String onSucess(CupomData cupomAccept){
    Navigator.of(context).pop();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Agora você tem desconto"), backgroundColor: Colors.greenAccent, duration: Duration(seconds: 2),));
    _cupom = cupomAccept;
  }

  String setCupom(){
    return _cupom == null ? "INSERIR CUPOM" : _cupom.id.toUpperCase();
  }

  onFailure(String errorMessage){
    Navigator.of(context).pop();
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.redAccent, duration: Duration(seconds: 2),));
    //_cupom = null;
  }
}
