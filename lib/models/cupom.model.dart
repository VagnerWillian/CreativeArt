import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/cupom.data.dart';

class CupomModel{

  CupomData _cupomData;

  CupomModel(this._cupomData);

  Future<double> verificaCupom() async {
    print("Solicitando desconto: ${_cupomData.id}");
    return await _verificaCupomExist(_cupomData.id);
  }

  Future<double> _verificaCupomExist(String cupomID) async {
    print("Verificando cupom: ${cupomID.toUpperCase()}");
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    CollectionReference _refCupons = _firestoreRef.collection("cupons");
    DocumentSnapshot cupomSelected = await  _refCupons.document(cupomID).get();
    if(cupomSelected.exists){
      return cupomSelected.data['porcent'].toDouble();
    }else{
      return 0.0;
    }
  }


  /*  bool isExpired(CupomData cupomData){
    if(Timestamp.now().toDate().isBefore(cupomData.expire.toDate())){
      return false;
    }else{
      return true;
    }
  }*/

  Future<int> validateCupom(String cupomID)async{
    Firestore _firestoreRef = Firestore.instance;
    CollectionReference _cuponsRef = _firestoreRef.collection("cupons");
    _firestoreRef.settings(persistenceEnabled: true);

    DocumentSnapshot cupom = await  _cuponsRef.document(cupomID).get();
    return cupom.data['porcent'];
  }


}