import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/user.data.dart';
import 'package:flutter/material.dart';

class FireUserModel{

  FireUserModel();

  static saveUserDataBasic({@required Map userMap}){
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    userMap.remove('pass');
    _firestoreRef.collection('clientes').document(userMap['id']).setData(userMap).catchError((ex){
      print(ex);
    });
  }

  static Future<UserData> loadUserData({@required String uid})async{
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    UserData userData;

    await _firestoreRef.collection("clientes").document(uid).get().then((userDocument){
      userData = UserData.fromJson(userDocument.data);
    });
    return userData;
  }

  static Stream<DocumentSnapshot> updateWallet({@required String uid}){
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    Stream walletStream = _firestoreRef.collection("clientes").document(uid).snapshots();
    return walletStream;
  }

}