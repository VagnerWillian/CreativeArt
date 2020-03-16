import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/cupom.data.dart';

class CupomModel{

  CupomData _cupomData;

  CupomModel(this._cupomData);

  Future<CupomData> verificaCupom() async {
    print("Solicitando desconto: ${_cupomData.id}");
    CupomData cupomAsVerify = await _verificaCupomExist(_cupomData.id);
    return cupomAsVerify;
  }

  Future<CupomData> _verificaCupomExist(String cupomID) async {
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);

    CollectionReference _refCupons = _firestoreRef.collection("cupons");
    DocumentSnapshot cupomSelected = await  _refCupons.document(cupomID).get();

    print("Verificando se o cupom: ${cupomID.toUpperCase()} existe");

    if(cupomSelected.exists){
      CupomData cupom = CupomData.fromJson(cupomSelected.data);
      if(!isExpired(cupom)){
        return cupom;
      }else{
        return null;
      }
    }else{
      return null;
    }
  }


    bool isExpired(CupomData cupomData){
    if(Timestamp.now().toDate().isBefore(cupomData.expire.toDate())){
      return false;
    }else{
      return true;
    }
  }

}