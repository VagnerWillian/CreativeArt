import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireUserModel{

  static saveUserDataBasic({@required Map userMap}){
    Firestore _firestoreRef = Firestore.instance;
    userMap.remove('pass');
    _firestoreRef.collection('clientes').document(userMap['id']).setData(userMap).catchError((ex){
      print(ex);
    });
  }

  static loadUserData({@required String uid})async{
    Firestore _firestoreRef = Firestore.instance;
    await _firestoreRef.collection("clientes").document(uid).get().then((userData){
      print(userData);
    });
  }

}