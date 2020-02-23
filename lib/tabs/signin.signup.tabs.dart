import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/componentes/textformfield/login.signup.input.dart';
import 'package:creative_app/models/validators.forms.dart';
import 'package:creative_app/pack/off/rounded_loading_button.dart';
import 'package:creative_app/screens/shopping.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:toast/toast.dart';

class FormsTabs{

  TabController tabController;
  BuildContext context;

  TextEditingController nameController = TextEditingController();
  TextEditingController whatsappController = MaskedTextController(mask: '(00)000000000');
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();

  FormsTabs({@required BuildContext context, @required this.tabController});
  final _loginformKey = GlobalKey<FormState>();
  final _registerformKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnLoginController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnRegisterController = new RoundedLoadingButtonController();

  Widget LoginTab(){

    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _loginformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextInputCustom(hint: "Email", controller: emailController, validator: Validators.emailValidator, textInputType: TextInputType.emailAddress)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextInputCustom(hint: "Senha", obscure: true, controller: passController, validator: Validators.passValidator, textInputType: TextInputType.text)
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Esqueci minha senha",
                      style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                    )),
                Column(
                  children: <Widget>[
                    Container(
                        width: 350,
                        height: 100,
                        padding: EdgeInsets.only(top: 50),
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color: Colors.purpleAccent,
                          child: Text("Entrar", style: TextStyle(color: Colors.white),),
                        )),

                    Container(
                        width: 350,
                        height: 60,
                        padding: EdgeInsets.only(top: 10),
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.grey[800]),
                          onPressed: () {goCreate();},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          child: Text("Criar uma conta", style: TextStyle(color: Colors.grey[500]),),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget RegisterTab(){

    nameController.text = "Vagner";
    whatsappController.text = "11959686501";
    emailController.text = "tec_vagner.ti@outlook.com";
    passController.text = "abc123";
    confirmPassController.text = "abc123";

    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _registerformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextInputCustom(hint: "Nome Completo", controller: nameController, validator: Validators.nameValidator, onChanged: _onChanged, textInputType: TextInputType.text)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextInputCustom(hint: "WhatsApp", controller: whatsappController, validator: Validators.whatsValidator, onChanged: _onChanged, textInputType: TextInputType.phone)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextInputCustom(hint: "Email", controller: emailController, validator: Validators.emailValidator, onChanged: _onChanged, textInputType: TextInputType.emailAddress)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextInputCustom(hint: "Senha", obscure: true, controller: passController, validator: Validators.passValidator, onChanged: _onChanged, textInputType: TextInputType.text)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextInputCustom(hint: "Confirmar Senha", obscure: true, controller: confirmPassController, validator: _confirmPass, onChanged: _onChanged, textInputType: TextInputType.text)
                  ),
                ),
                SizedBox(height: 15,),
                Column(
                  children: <Widget>[
                    RoundedLoadingButton(
                      child: Text('Criar conta', style: TextStyle(color: Colors.white)),
                      controller: _btnRegisterController,
                      onPressed: _createAccout,
                    ),
                    Container(
                        width: 350,
                        height: 60,
                        padding: EdgeInsets.only(top: 10),
                        child: OutlineButton(
                          borderSide: BorderSide(color: Colors.grey[800]),
                          onPressed: () {goLogin();},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          child: Text("Já possuo uma conta", style: TextStyle(color: Colors.grey[500]),),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onChanged(String str){
    _btnRegisterController.reset();
  }

  _confirmPass(String str){
    if (str != passController.text) {
      return "Repetiu a senha errada";
    }
  }

  goCreate(){
    tabController.animateTo(1);
  }

  goLogin(){
    tabController.animateTo(0);
  }

  _createAccout(){
      if(_registerformKey.currentState.validate()){

        Map<String, dynamic> userMap = {
          'name':nameController .text,
          'whatsapp': whatsappController.text,
          'email':emailController.text,
          'pass':confirmPassController.text,
        };

        loginAndRegisterBloc.SignUp(userMap: userMap, onSucess: _registerOnSucess, onFailure: _registerOnFailure);
        _btnRegisterController.success();
        _registerOnSucess();
      }else{
        _btnRegisterController.error();
      }
  }

  _registerOnSucess(){
    Navigator.pushReplacement(_registerformKey.currentState.context, MaterialPageRoute(builder: (context)=>ShopScreen()));
  }

  _registerOnFailure(String msg){
    Toast.show(msg, _registerformKey.currentState.context, backgroundColor: Colors.redAccent, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);

  }

  enterAccount(){
      tabController.animateTo(0);
  }
}