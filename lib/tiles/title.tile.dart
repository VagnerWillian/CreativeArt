import 'package:flutter/material.dart';

Widget TitleTile(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            "CREATIVE",
            style: TextStyle(
                wordSpacing: 2, color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            "art.",
            style: TextStyle(
                wordSpacing: 2,
                color: Colors.purpleAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      )
    ],
  );
}