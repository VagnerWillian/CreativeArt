import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/data/cupom.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:flutter/material.dart';

class CupomDialog extends StatefulWidget {

  Function _onSucess;
  Function _onFailure;

  FlyerData _flyerData;

  CupomDialog(this._flyerData, this._onSucess, this._onFailure);


  @override
  _CupomDialogState createState() => _CupomDialogState(this._flyerData, this._onSucess, this._onFailure);
}

class _CupomDialogState extends State<CupomDialog> {

  Function _onSucess;
  Function _onFailure;

  FlyerData _flyerData;

  _CupomDialogState(this._flyerData, this._onSucess, this._onFailure);

  TextEditingController _cupomController = TextEditingController();
  CupomData _cupom;

  final loginAndSignUpBloc = BlocProvider.getBloc<LoginAndRegister>();
  final _cupomFormKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topLeft:  Radius.circular(20))),
      child: Container(
        //padding: EdgeInsets.all(10),
        child: Form(
          key: _cupomFormKey,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "DIGITE O CÓDIGO DO CUPOM",
                        border: InputBorder.none
                    ),
                    style: TextStyle(color: Colors.grey[600]),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    controller: _cupomController,
                    validator: (str){
                      if(str.length < 3){
                        return "Cupom muito pequeno";
                      }else{
                        try{
                          if(loginAndSignUpBloc.actuallyUser.promotionId == str){
                            return "Você não pode usar seu próprio código";
                          }
                        }catch(x){}
                      }
                      return null;
                    },
                  ),
                ),
                isLoading ? Column(
                  children: <Widget>[
                    Container(
                      // width: 30,
                        height: 3,
                        child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.yellow[800]),backgroundColor: Colors.white,)
                    ),
                  ],
                ) :
                Container(
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),)),
                    elevation: 0,
                    color: Colors.yellow[800],
                    onPressed: checkCupom,
                    child: Text("Verificar"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }

  onLoading(){
    isLoading = true;
    setState(() {});
  }

  offLoading(){
    isLoading = false;
    setState(() {});
  }

  checkCupom()async{
    CupomData _verifyCupom;
    if(_cupomFormKey.currentState.validate()){
      onLoading();
      _verifyCupom = CupomData(id: _cupomController.text.toUpperCase());
      if(_cupom == null){
        await _flyerData.addDiscountFromCupom(_verifyCupom, onFailure: _onFailure, onSucess: _onSucess);
      }else{
        this._onFailure("Um cupom já foi inserido");
      }
    }

   offLoading();
  }
}
