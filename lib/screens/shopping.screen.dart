import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/screens/splash_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  String URL_ANIMATION = "assets/anims/confirm.flr";
  final loginAndRegisterBloc = BlocProvider.getBloc<LoginAndRegister>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(38, 39, 46,1),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: ()async{
                await loginAndRegisterBloc.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashScreen()));
                print("Usuario deslogado");
              },
              child: Container(
                  height: 200,
                  width: 200,
                  child: FlareActor(URL_ANIMATION, animation: 'check',)),
            ),
            Text("Seja bem vindo", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
            RaisedButton(
              child: Text('DELETAR conta', style: TextStyle(color: Colors.white)),
              onPressed: (){loginAndRegisterBloc.deleteUserTest();},
            ),
          ],
        ),
      ),
    );
  }
}
