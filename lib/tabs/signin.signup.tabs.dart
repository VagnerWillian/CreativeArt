import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/components/input/login.signup.input.dart';
import 'package:creative_app/models/validators.forms.dart';
import 'package:creative_app/pack/off/rounded_loading_button.dart';
import 'package:creative_app/screens/shopping.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:toast/toast.dart';

class FormsTabs{

  TabController tabController;
  TextEditingController nameController = TextEditingController();
  TextEditingController whatsappController = MaskedTextController(mask: '(00)000000000');
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();

  FormsTabs({@required this.tabController});
  final _loginformKey = GlobalKey<FormState>();
  final _registerformKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnLoginController = new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnRegisterController = new RoundedLoadingButtonController();

  Widget LoginTab(){

    emailController.text = "tec_vagner.ti@outlook.com";
    passController.text = "abc123";

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
                        child:RoundedLoadingButton(
                          child: Text('Entrar', style: TextStyle(color: Colors.white)),
                          controller: _btnLoginController,
                          onPressed: _loginAccount,
                        ),
                    ),
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

    nameController.text = "Vagner Willian Martin";
    whatsappController.text = "11959686501";
    emailController.text = "tec_vagner.ti@outlook.com";
    passController.text = "abc123";
    confirmPassController.text = "abc123";

    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: IgnorePointer(
            ignoring: false,
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

  _loginAccount()async{
    await loginAndRegisterBloc.loginWithEmail(email: emailController.text, pass: passController.text, onSucess: _loginOnSucess, onFailure: _loginOnFailure);
  }

  _createAccout(){
      if(_registerformKey.currentState.validate()){
        Map<String, dynamic> userMap = {
          'name':nameController .text,
          'avatar': "https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png",
          'whatsapp': whatsappController.text,
          'email':emailController.text,
          'pass':confirmPassController.text,
          'myWallet':0.0,
          'indicateFrom' : null
        };

        loginAndRegisterBloc.SignUp(userMap: userMap, onSucess: _registerOnSucess, onFailure: _registerOnFailure);
      }else{
        _btnRegisterController.error();
      }
  }

  _registerOnSucess() async {
    print("Conta criada com sucesso");
    _btnRegisterController.success();
    await Future.delayed((Duration(seconds: 1)));
    Navigator.pushReplacement(_registerformKey.currentState.context, MaterialPageRoute(builder: (context)=>ShopScreen()));
  }

  _registerOnFailure(String msg)async{
    print("Falha ao criar sua conta");
    Toast.show(msg, _registerformKey.currentState.context, backgroundColor: Colors.redAccent, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    _btnRegisterController.error();
    await Future.delayed(Duration(seconds: 1));
    _btnRegisterController.reset();
  }

  _loginOnSucess() async {
    print("Login realizado");
    _btnLoginController.success();
    await Future.delayed((Duration(seconds: 1)));
    Navigator.pushReplacement(_loginformKey.currentState.context, MaterialPageRoute(builder: (context)=>ShopScreen()));
  }

  _loginOnFailure(String msg)async{
    print("Erro ao realizar login");
    Toast.show(msg, _loginformKey.currentState.context, backgroundColor: Colors.redAccent, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    _btnLoginController.error();
    await Future.delayed(Duration(seconds: 1));
    _btnLoginController.reset();
  }

  enterAccount(){
      tabController.animateTo(0);
  }
}