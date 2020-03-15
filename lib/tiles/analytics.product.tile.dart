import 'package:creative_app/models/validators.forms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalyticsBar{

  static Widget AnalyticBar({@required double value, @required IconData icon, @required String title}){
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: Colors.grey, size: 18,),
              SizedBox(width: 10,),
              Text(Validators.convertToAnalytic(value), style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 5),
          Text(title.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w300),)
        ],
      ),
    );
  }

}