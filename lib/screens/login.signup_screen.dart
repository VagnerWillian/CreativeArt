import 'package:creative_app/tabs/signin.signup.tabs.dart';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "CREATIVE",
              style: TextStyle(wordSpacing: 2, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              "art.",
              style: TextStyle(wordSpacing: 2, color: Colors.purpleAccent, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: <Widget>[
                FormsTabs(context: context, tabController: tabController).LoginTab(),
                FormsTabs(context: context, tabController: tabController ).RegisterTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
}
