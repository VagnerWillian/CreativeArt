import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/blocs/geral_bloc.dart';
import 'package:creative_app/data/category.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CatalogBloc implements BlocBase {

  final _catalogController = BehaviorSubject<Map<String, dynamic>>();
  Observable<Map<String, dynamic>> get getCatalogList => _catalogController.stream;
  Sink<Map<String, dynamic>> get setCatalogList => _catalogController.sink;
  Map<String, dynamic> get actuallyListCatalog => _catalogController.value;
  Map<String, dynamic> _catalog = {};
  int discountGeral = 0;

  Future<List<CategoryData>> loadCategories()async{
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    List<CategoryData> _categories = [];
    Map<String, dynamic> _catalog = {};

    await _firestoreRef.collection("categorias").getDocuments().then((categoryDocument)async{
      for(DocumentSnapshot doc in categoryDocument.documents){
        CategoryData _category = CategoryData.fromJson(doc.data);
        _catalog = await loadFlyersFromCategory(categoryID: _category.id, increment: 3);
        if(_catalog[_category.id].length > 0){
          _categories.add(_category);
        }else{
          print("Categoria ${doc.data['title']}, do ID: ${doc.data['id']} está vazio.");
        }
      }
    });
    return _categories;
  }

  loadFlyersFromCategory({@required String categoryID, @required increment, VoidCallback scroll})async{

    Firestore _firestoreRef = Firestore.instance;
    CollectionReference _produtosRef = _firestoreRef.collection("produtos");
    _firestoreRef.settings(persistenceEnabled: true);

    List<FlyerData> _flyers = [];
    /*int descontos = await verificaDescontos();
    print("DESCONTOS À SEREM APLICADOS DE FORMA GERAL: ${descontos}");
*/
    await _produtosRef.limit(_catalog[categoryID] != null ? _catalog[categoryID].length + increment: increment).where("category", isEqualTo: categoryID).getDocuments().then((productDocument) async {
      print("Items baixados: ${productDocument.documents.length} da categoria ${categoryID}");
      for(DocumentSnapshot doc in productDocument.documents){
        FlyerData _flyerData = FlyerData.fromJson(doc.data);

        final catalogBloc = BlocProvider.getBloc<GeralBloc>();
        _flyerData.addDiscount(percent: catalogBloc.geralConfig.discountGeral);


        _flyers.add(_flyerData);
      }
    });
    _catalog.addAll({categoryID: _flyers});
    setCatalogList.add(_catalog);
    return _catalog;
  }

  saveCatalogData(FlyerData flyerData) async {
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);

    await _firestoreRef.collection("produtos").document(flyerData.id).updateData(flyerData.toJson());
    print("Alteração do flyer salvo");

  }

  addViewFlyer(FlyerData flyerData){
    flyerData.addView();
    saveCatalogData(flyerData);
  }

  @override
  void dispose() {
    _catalogController.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
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