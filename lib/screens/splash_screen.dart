import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.signup_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40,255),
      body: Container(
        decoration: BoxDecoration(
              /*image: DecorationImage(
                fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      "https://images.unsplash.com/flagged/photo-1564434369363-696a2e6d96f9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80")
              )*/
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                    Colors.black,
                    Color.fromRGBO(63, 1, 73,0.3),
                ])
        ),
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(FontAwesomeIcons.tint, color: Colors.purpleAccent, size: 50,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("CREATIVE", style: TextStyle(wordSpacing: 2, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                    Text("art.", style: TextStyle(wordSpacing: 2, color: Colors.purpleAccent, fontWeight: FontWeight.bold, fontSize: 20),),
                  ],
                ),
                Text("Os melhores cartazes para sua igreja", style: TextStyle(color: Colors.grey),),
                SizedBox(height: 100,),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              ],
            ),
          )
        ),
      ),
    );
  }

  Future<Null> exitToSplash()async{
    print(loginAndRegisterBloc);
    if(loginAndRegisterBloc.getLoggedStatus()){
      print("Você esta logado!");
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginAndSignUpScreen()));
    }
  }

  @override
  void initState() {
    exitToSplash();
    super.initState();
  }

}