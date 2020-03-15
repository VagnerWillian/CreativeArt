import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/models/cupom.model.dart';

class GeralBloc implements BlocBase{

  int discountGeral;

  GeralBloc() {}

  verificaSeHaCupomGeral() async {
    Firestore _firestoreRef = Firestore.instance;
    CollectionReference _geralRef = _firestoreRef.collection("geral");
    _firestoreRef.settings(persistenceEnabled: true);
    DocumentSnapshot cupomGeral = await  _geralRef.document("cupomGeral").get();
    if(cupomGeral.data['id'] == null){
      discountGeral = 0;
    }else{
      discountGeral = await Cupom(cupomGeral.data['id']).verificaCupom(cupomGeral.data['id']);
    }
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

}