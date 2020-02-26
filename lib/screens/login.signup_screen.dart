import 'package:creative_app/screens/shopping.screen.dart';
import 'package:creative_app/tabs/signin.signup.tabs.dart';
import 'package:creative_app/tiles/title.tile.dart';
import 'package:flutter/material.dart';

class LoginAndSignUpScreen extends StatefulWidget {
  @override
  _LoginAndSignUpScreenState createState() => _LoginAndSignUpScreenState();
}

class _LoginAndSignUpScreenState extends State<LoginAndSignUpScreen> with SingleTickerProviderStateMixin{

  TabController tabController;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(onPressed: (){
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopScreen()));
        },
          color: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.arrow_left, color: Colors.white,),
        ),
        title: Container(margin: EdgeInsets.only(right: 50),child: TitleTile())
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: <Widget>[
                FormsTabs(tabController: tabController).LoginTab(),
                FormsTabs(tabController: tabController ).RegisterTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
}
