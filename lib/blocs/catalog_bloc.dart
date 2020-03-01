import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/category.flyter.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CatalogBloc implements BlocBase {

  final _catalogController = BehaviorSubject<Map<String, dynamic>>();
  Observable<Map<String, dynamic>> get getCatalogList => _catalogController.stream;
  Sink<Map<String, dynamic>> get setCatalogList => _catalogController.sink;
  Map<String, dynamic> get actuallyListCatalog => _catalogController.value;
  Map<String, dynamic> _catalog = {};

  CatalogBloc() {
    loadCategories();
   // loadFlyersFromCategory(categoryID: "FFQIsuNwEHOCyYxVmE5X");
  }

  Future<List<CategoryData>> loadCategories()async{
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    List<CategoryData> _categories = [];
    Map<String, dynamic> _catalog = {};

    await _firestoreRef.collection("categorias").getDocuments().then((categoryDocument)async{
      for(DocumentSnapshot doc in categoryDocument.documents){
        CategoryData _category = CategoryData.fromJson(doc.data);
        _catalog = await loadFlyersFromCategory(categoryID: doc.data['id'], increment: 4);
        if(_catalog[doc.data['id']].length > 0){
          _categories.add(_category);
        }else{
          print("Categoria ${doc.data['title']}, do ID: ${doc.data['id']} está vazio.");
        }
      }
    });
    return _categories;
  }

  loadFlyersFromCategory({@required String categoryID, @required increment})async{
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);

    List<FlyerData> _flyers = [];

    await _firestoreRef.collection("produtos").limit(increment).where("category", isEqualTo: categoryID).getDocuments().then((productDocument){
      for(DocumentSnapshot doc in productDocument.documents){
        FlyerData _flyerData = FlyerData.fromJson(doc.data);
        _flyers.add(_flyerData);
      }
    });
    _catalog.addAll({categoryID: _flyers});
    setCatalogList.add(_catalog);
    return _catalog;
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