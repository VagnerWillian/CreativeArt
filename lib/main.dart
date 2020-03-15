import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:creative_app/blocs/catalog_bloc.dart';
import 'package:creative_app/blocs/geral_bloc.dart';
import 'package:creative_app/blocs/login_register_bloc.dart';
import 'package:creative_app/screens/splash.screen.dart';
import 'package:flutter/material.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) =>  LoginAndRegister()),
        Bloc((i) =>  CatalogBloc()),
        Bloc((i) =>  GeralBloc()),
      ],
      child: MaterialApp(
        title: 'CreativeArt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(38, 39, 46,1),
          scaffoldBackgroundColor: Color.fromRGBO(25, 26, 31,1),
          primarySwatch: Colors.blue,
          textTheme: TextTheme(body1: TextStyle(color: Colors.white)),
        ),
        home: SplashScreen(),
      ),
    );
  }
}