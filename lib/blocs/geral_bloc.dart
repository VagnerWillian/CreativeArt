import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/cupom.data.dart';
import 'package:creative_app/data/geral.data.dart';
import 'package:creative_app/models/cupom.model.dart';

class GeralBloc implements BlocBase{

  GeralData geralConfig = GeralData();

  GeralBloc();

  loadConfigs()async{
     await verificaSeHaCupomGeral();
  }

  Future<int> verificaSeHaCupomGeral() async {
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);

    CollectionReference _geralRef = _firestoreRef.collection("geral");
    DocumentSnapshot cupomGeral = await  _geralRef.document("cupomGeral").get();

    if(cupomGeral.data['id']!= null){

      CupomData startCupom = CupomData.fromJson(cupomGeral.data);
      double discountReceived = await CupomModel(startCupom).verificaCupom();

      print("Um descondo geral foi atribuido ${discountReceived}%");
      geralConfig.discountGeral = discountReceived;
    }else{
      print("Nenhum cupom esta atribuido");
      geralConfig.discountGeral = 0.0;
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