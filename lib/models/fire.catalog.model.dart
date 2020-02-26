import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/category.flyter.data.dart';
import 'package:creative_app/data/flyer.data.dart';
import 'package:random_string/random_string.dart';

class FireCatalogModel{

  FireCatalogModel();

  static addCatalogTestes(){
    CategoryData categoryData1 = CategoryData(
      id: "FFQIsuNwEHOCyYxVmE5X",
      title: "Vigília"
    );

    FlyerData flyerData1 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Mega Vigília do efatá",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/87987868_2312633265701404_1130308458843734016_o.jpg?_nc_cat=110&_nc_ohc=7lfUmZ6uWWoAX-iaIF1&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=009f46046d402090377ee9c44a40c4f3&oe=5EBAFB54",
        price: 49.99,
        discount: 50.0,
        category: categoryData1.id
    );

    FlyerData flyerData2 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "A unção que quebra o Julgo",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/85184791_2312625622368835_6875183909982699520_o.jpg?_nc_cat=109&_nc_ohc=9DoK62n6Nc8AX8YtCzx&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=f302e9d7da672cebcf67ea2bbefee3cb&oe=5EC38D7C",
        price: 39.99,
        discount: 20.0,
        category: categoryData1.id
    );

    FlyerData flyerData3 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Culto de Ação de Graças Ebenezer",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-0/p640x640/85194507_2312574902373907_32221763777593344_o.jpg?_nc_cat=109&_nc_ohc=vTKB-PaS1xoAX_WcG1M&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=6&oh=a3617b3e769c674ecaa55e209fff1123&oe=5EFB0400",
        price: 64.99,
        discount: 30.0,
        category: categoryData1.id
    );

    FlyerData flyerData4 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Mega Conferência",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86801599_2308434706121260_8684112646296829952_o.jpg?_nc_cat=102&_nc_ohc=YUqKgfjzMgcAX_PYWO4&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=42e940aca7b45758c67915fb4b0aa2e8&oe=5EEF5885",
        price: 79.99,
        discount: 10.0,
        category: categoryData1.id
    );

    FlyerData flyerData5 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "12 Cestos Cheios para 12 meses de vitória",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86853634_2307181252913272_4041811469623361536_o.jpg?_nc_cat=111&_nc_ohc=WYnatKWow5gAX-OuXWL&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=e16d6a1af40be2011013caae2b40fefd&oe=5EFC8060",
        price: 99.99,
        discount: 0.0,
        category: categoryData1.id
    );

    FlyerData flyerData6 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Quinta-feira da vitória",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86790883_2306986382932759_8885689742264369152_o.jpg?_nc_cat=109&_nc_ohc=g5_onzskyXIAX9Pdj3W&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=15fe4a3bc32e0addfb4f1a8bf300063a&oe=5EFF7FA9",
        price: 29.99,
        discount: 5.0,
        category: categoryData1.id
    );

    FlyerData flyerData7 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Abala Jd. Britânia",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86387313_2304133463218051_4247809611651874816_o.jpg?_nc_cat=111&_nc_ohc=DX0sN8IyS1cAX-9o8_j&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=f599bbe4477e5e506773945e25b4fda6&oe=5EEEBF4C",
        price: 39.99,
        discount: 30.0,
        category: categoryData1.id
    );

    FlyerData flyerData8 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Os valentes vestem vermelho",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/84333636_2303218249976239_7052857382644219904_o.jpg?_nc_cat=101&_nc_ohc=bYd2aa-eN6YAX_Tv9l8&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=6b28e0498b0c1d121d1b285d12584dee&oe=5EF0881E",
        price: 49.99,
        discount: 50.0,
        category: categoryData1.id
    );

    FlyerData flyerData9 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Mega Conferência",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/84142527_2303100296654701_2488372127086936064_o.jpg?_nc_cat=109&_nc_ohc=0gjqxFZwtQ4AX-MJo5G&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=bf2075e27c1fbd90443704cd27e9f8d3&oe=5EFF20DF",
        price: 69.99,
        discount: 20.0,
        category: categoryData1.id
    );

    FlyerData flyerData10 = FlyerData(
        id: randomAlphaNumeric(10),
        title: "Segunda Profética",
        src: "https://scontent.fcgh2-1.fna.fbcdn.net/v/t1.0-9/s960x960/86389606_2302381596726571_5752519861565652992_o.jpg?_nc_cat=111&_nc_ohc=mcKTwZKICMUAX-s9yAZ&_nc_ht=scontent.fcgh2-1.fna&_nc_tp=7&oh=da42bd6610c42bde8296aec5b27ae89a&oe=5EBD81F3",
        price: 5.99,
        discount: 25.0,
        category: categoryData1.id
    );

    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);

    List<FlyerData> _listFlyers = [flyerData1, flyerData2, flyerData3, flyerData4, flyerData5,
      flyerData6, flyerData7, flyerData8, flyerData9, flyerData10];

    for(FlyerData flyerData in _listFlyers){
      _firestoreRef.collection('produtos').document(flyerData.id).setData(flyerData.toJson()).then((result){
        print("Adicionado ${flyerData.title}");
      }).catchError((ex){
        print(ex);
      });
    }

  }

  static deleteAllCatalogTestes(){
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);

    _firestoreRef.collection('produtos').reference().getDocuments().then((result){
      for(DocumentSnapshot doc in result.documents){
        doc.reference.delete();
        print("Deltado ${doc.data['title']}");
      }
    }).catchError((ex){
      print(ex);
    });
  }

  static Future<List<FlyerData>> loadCategoriesTest()async{
    Firestore _firestoreRef = Firestore.instance;
    _firestoreRef.settings(persistenceEnabled: true);
    List<FlyerData> _flyers = [];

    await _firestoreRef.collection("produtos").limit(6).getDocuments().then((productDocument){
      for(DocumentSnapshot doc in productDocument.documents){
        FlyerData _flyerData = FlyerData.fromJson(doc.data);
        _flyers.add(_flyerData);
      }
    });
    return _flyers;
  }
}