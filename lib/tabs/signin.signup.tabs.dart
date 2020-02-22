import 'package:creative_app/componentes/textformfield/login.signup.input.dart';
import 'package:flutter/material.dart';

class FormsTabs{

  TabController tabController;

  TextEditingController nameController = TextEditingController();
  TextEditingController sobrenameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  FormsTabs({this.tabController});

  Widget LoginTab({TabController tabController}){

    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //    Text("Fazer Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextInputCustom("Email", controller: emailController)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextInputCustom("Senha", obscure: true, controller: passController)
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
                        onPressed: () {createAccout();},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        child: Text("Criar uma conta", style: TextStyle(color: Colors.grey[500]),),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget RegisterTab(){
    return Center(
      child: Container(
        child: SingleChildScrollView(
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
                    child: TextInputCustom("Nome", controller: nameController)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextInputCustom("Sobrenome", controller: sobrenameController)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextInputCustom("Email", controller: emailController)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextInputCustom("Senha", obscure: true, controller: passController)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextInputCustom("Senha", obscure: true, controller: confirmPassController)
                ),
              ),
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
                        child: Text("Criar conta", style: TextStyle(color: Colors.white),),
                      )),
                  Container(
                      width: 350,
                      height: 60,
                      padding: EdgeInsets.only(top: 10),
                      child: OutlineButton(
                        borderSide: BorderSide(color: Colors.grey[800]),
                        onPressed: () {enterAccount();},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        child: Text("Já possuo uma conta", style: TextStyle(color: Colors.grey[500]),),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  createAccout(){
      tabController.animateTo(1);
  }

  enterAccount(){
      tabController.animateTo(0);
  }
}