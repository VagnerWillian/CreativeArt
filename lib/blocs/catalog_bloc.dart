import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/category.flyter.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CatalogBloc implements BlocBase {

  final _catalogController = BehaviorSubject<List<FlyerData>>();
  Observable<List<FlyerData>> get getCatalogList => _catalogController.stream;
  Sink<List<FlyerData>> get setCatalogList => _catalogController.sink;
  List<FlyerData> get actuallyListCatalog => _catalogController.value;

  CatalogBloc() {
    loadCategories();
    loadFlyersFromCategory(categoryID: "FFQIsuNwEHOCyYxVmE5X");
  }

  Future<List<CategoryData>> loadCategories()async{
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    List<CategoryData> _categories = [];

    await _firestoreRef.collection("categorias").getDocuments().then((categoryDocument){
      for(DocumentSnapshot doc in categoryDocument.documents){
        CategoryData _category = CategoryData.fromJson(doc.data);
        _categories.add(_category);
      }
    });
    return _categories;
  }

  loadFlyersFromCategory({@required String categoryID})async{
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    List<FlyerData> _flyers = [];

    await _firestoreRef.collection("produtos").limit(6).where("category", isEqualTo: categoryID).getDocuments().then((productDocument){
 //     print("CATALOGOS CARREGADOS => ${productDocument.documents}");

      for(DocumentSnapshot doc in productDocument.documents){
        FlyerData _flyerData = FlyerData.fromJson(doc.data);
        _flyers.add(_flyerData);
      }
    });

    setCatalogList.add(_flyers);
  }

  List<FlyerData> get actuallyUser => _catalogController.value;

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