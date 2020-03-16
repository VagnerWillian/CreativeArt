import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/category.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:creative_app/data/user.data.dart';
import 'package:random_string/random_string.dart';

class FireCatalogModel{

  FireCatalogModel();

  static addCatalogTestes(){
    CategoryData categoryData1 = CategoryData(
      id: "FFQIsuNwEHOCyYxVmE5X",
      title: "Vigília",
    );

    FlyerData flyerData1 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Mega Vigília do efatá",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/87987868_2312633265701404_1130308458843734016_o.jpg?_nc_cat=110&_nc_ohc=7lfUmZ6uWWoAX-iaIF1&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=009f46046d402090377ee9c44a40c4f3&oe=5EBAFB54",
        price: 81.99,
        discount: [0.0],
        category: categoryData1.id,
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData2 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "A unção que quebra o Julgo",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/85184791_2312625622368835_6875183909982699520_o.jpg?_nc_cat=109&_nc_ohc=9DoK62n6Nc8AX8YtCzx&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=f302e9d7da672cebcf67ea2bbefee3cb&oe=5EC38D7C",
        price: 81.99,
        discount: [0.0],
        category: categoryData1.id,
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData3 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Pré-Congresso UMINAN",
        src: "https://i.ibb.co/L1bJGbm/PRECONGRESSO-UMINAM.png",
        price: 81.99,
        discount: [0.0],
        category: categoryData1.id,
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData4 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Mega Conferência",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86801599_2308434706121260_8684112646296829952_o.jpg?_nc_cat=102&_nc_ohc=YUqKgfjzMgcAX_PYWO4&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=42e940aca7b45758c67915fb4b0aa2e8&oe=5EEF5885",
        price: 81.99,
        discount: [0.0],
        category: categoryData1.id,
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData5 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "12 Cestos Cheios para 12 meses de vitória",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86853634_2307181252913272_4041811469623361536_o.jpg?_nc_cat=111&_nc_ohc=WYnatKWow5gAX-OuXWL&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=e16d6a1af40be2011013caae2b40fefd&oe=5EFC8060",
        price: 81.99,
        discount: [0.0],
        category: "wwvRf1MPyruBqP4tBtUP",
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData6 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Quinta-feira da vitória",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86790883_2306986382932759_8885689742264369152_o.jpg?_nc_cat=109&_nc_ohc=g5_onzskyXIAX9Pdj3W&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=15fe4a3bc32e0addfb4f1a8bf300063a&oe=5EFF7FA9",
        price: 81.99,
        discount: [0.0],
        category: categoryData1.id,
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData7 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Abala Jd. Britânia",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86387313_2304133463218051_4247809611651874816_o.jpg?_nc_cat=111&_nc_ohc=DX0sN8IyS1cAX-9o8_j&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=f599bbe4477e5e506773945e25b4fda6&oe=5EEEBF4C",
        price: 81.99,
        discount: [0.0],
        category: categoryData1.id,
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData8 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "1º Congresso UVADB",
        src: "https://i.ibb.co/JCtRM0b/CONGRESSO-UVADB.png",
        price: 81.99,
        discount: [0.0],
        category: categoryData1.id,
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData9 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Mega Conferência",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/84142527_2303100296654701_2488372127086936064_o.jpg?_nc_cat=109&_nc_ohc=0gjqxFZwtQ4AX-MJo5G&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=bf2075e27c1fbd90443704cd27e9f8d3&oe=5EFF20DF",
        price: 81.99,
        discount: [0.0],
        category: categoryData1.id,
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    FlyerData flyerData10 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Segunda Profética",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86389606_2302381596726571_5752519861565652992_o.jpg?_nc_cat=111&_nc_ohc=mcKTwZKICMUAX-s9yAZ&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=da42bd6610c42bde8296aec5b27ae89a&oe=5EBD81F3",
        price: 81.99,
        discount: [0.0],
        category: "DwUaeEKb6ysQU4AZS0Bo",
        cupom: 0,
        views: 0.0,
        sell: 0.0,
        rate: 0.0
    );

    Firestore _firestoreInstance = Firestore.instance;
    _firestoreInstance.settings(persistenceEnabled: true);
    CollectionReference _FirestoreRef = _firestoreInstance.collection("produtos");

    List<FlyerData> _listFlyers = [flyerData1, flyerData2, flyerData3, flyerData4, flyerData5,
      flyerData6, flyerData7, flyerData8, flyerData9, flyerData10];

    for(FlyerData flyerData in _listFlyers){
      _FirestoreRef.document(flyerData.id).setData(flyerData.toJson()).then((result){
        print("Adicionado ${flyerData.title}");
      }).catchError((ex){
        print(ex);
      });
    }

  }

  static deleteAllCatalogTestes(){
    Firestore _firestoreInstance = Firestore.instance;
    _firestoreInstance.settings(persistenceEnabled: true);
    CollectionReference _FirestoreRef = _firestoreInstance.collection("produtos");

    _FirestoreRef.reference().getDocuments().then((result){
      for(DocumentSnapshot doc in result.documents){
        doc.reference.delete();
        print("Deletado ${doc.data['title']}");
      }
    }).catchError((ex){
      print(ex);
    });
  }

  static Future<List<FlyerData>> loadCategoriesTest()async{
    Firestore _firestoreInstance = Firestore.instance;
    _firestoreInstance.settings(persistenceEnabled: true);
    CollectionReference _FirestoreRef = _firestoreInstance.collection("produtos");

    List<FlyerData> _flyers = [];

    await _FirestoreRef.limit(6).getDocuments().then((productDocument){
      for(DocumentSnapshot doc in productDocument.documents){
        FlyerData _flyerData = FlyerData.fromJson(doc.data);
        _flyers.add(_flyerData);
      }
    });
    return _flyers;
  }

  static comprar(FlyerData flyerData, String userID){
    incrementSell(flyerData);
    saveRate(flyerData, userID);
  }

  static cancel(){

  }

  static incrementSell(FlyerData flyerData){
    Firestore _firestoreInstance = Firestore.instance;
    _firestoreInstance.settings(persistenceEnabled: true);
    CollectionReference _FirestoreRef = _firestoreInstance.collection("produtos");

    flyerData.sell += 1;
    _FirestoreRef.document(flyerData.id).setData(flyerData.toJson());
  }

  static saveRate(FlyerData flyerData, String userID) async {
    Firestore _firestoreInstance = Firestore.instance;
    _firestoreInstance.settings(persistenceEnabled: true);
    CollectionReference _FirestoreRef = _firestoreInstance.collection("produtos");

    final snapshot = await _FirestoreRef.document(flyerData.id).collection("feedback").document(userID).get();

   // if(!snapshot.exists){
      double rateInput = 5;
      var rate = {"rate":rateInput,"comment":"Muito lindo vey!"};
      snapshot.reference.setData(rate);
      incrementRate(flyerData, rateInput);
   // }

  }

  static incrementRate(FlyerData flyerData, double rate){
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    flyerData.rate =  (flyerData.rate + rate) / (flyerData.sell);
    print("${flyerData.rate} / ${flyerData.sell}");
    _firestoreRef.collection("produtos").document(flyerData.id).setData(flyerData.toJson());
  }
}