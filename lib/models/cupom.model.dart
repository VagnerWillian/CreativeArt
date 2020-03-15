import 'package:cloud_firestore/cloud_firestore.dart';

class Cupom{

  String id;

  Cupom(this.id){
    verificaCupomExist();
  }

  verificaCupomExist() async {
    Firestore _firestoreRef = Firestore.instance;
    CollectionReference _geralRef = _firestoreRef.collection("geral");
    _firestoreRef.settings(persistenceEnabled: true);
    DocumentSnapshot cupomGeral = await  _geralRef.document("cupomGeral").get();
    if(cupomGeral.data['id'] == null){
      return 0;
    }else{
      return await verificaCupom(cupomGeral.data['id']);
    }
  }

  Future<int> verificaCupom(String cupomID)async{
    Firestore _firestoreRef = Firestore.instance;
    CollectionReference _cuponsRef = _firestoreRef.collection("cupons");
    _firestoreRef.settings(persistenceEnabled: true);

    DocumentSnapshot cupom = await  _cuponsRef.document(cupomID).get();
    return cupom.data['porcent'];
  }


}