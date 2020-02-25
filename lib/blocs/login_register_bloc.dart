import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creative_app/data/user.data.dart';
import 'package:creative_app/models/fire.auth.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class LoginAndRegister implements BlocBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;

  final _userController = BehaviorSubject<UserData>();
  Observable<UserData> get getUser => _userController.stream;
  Sink<UserData> get setUser => _userController.sink;

  LoginAndRegister(){
    loadData();
  }

  UserData get actuallyUser => _userController.value;

  @override
  void dispose() {
    _userController.close();
  }

  Future<bool> isLogged()async{
    if (await _firebaseAuth.currentUser() == null){
      return false;
    }else{
      return true;
    }
  }

  loginWithEmail({@required String email, @required String pass, @required Function onSucess, @required onFailure})async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((result){
      _firebaseUser = result.user;
      loadData();
      onSucess();
    })
    .catchError((e){
      onFailure(errorAuth(e));
    })
    ;
  }

  deleteUserTest()async{
    Firestore _firestoreRef = Firestore.instance;
   try{
     await _firestoreRef.collection("clientes").document(_firebaseUser.uid).delete();
     await _firebaseUser.delete();
   }catch(ex){}
    signOut();
    print("Usuario deletado");
  }

  String idGenerator(){
    String promotion_id; /// 5 PRIMEIROS DIGITOS DO ID E 5 ÚLTIMOS
    promotion_id =  (_firebaseUser.uid.substring(0, 5) + _firebaseUser.uid.substring(_firebaseUser.uid.length-5)).toUpperCase();
    List<String> permitedChar =
        ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z', '0',
          '1', '2', '3', '4', '5', '6', '7', '8', '9', ];

    for(int x in promotion_id.runes){
        String char = String.fromCharCode(x);
        if(!permitedChar.contains(char)){
          String newChar = permitedChar[Random.secure().nextInt(36)];
          promotion_id = promotion_id.replaceAll(char, newChar);
          print("O caractere ${char} do CUPOM foi substituído pelo char ${newChar} por ser incompatível.");
        }
    }
    return promotion_id;
  }

    SignUp({@required Map<String,dynamic> userMap, @required VoidCallback onSucess, @required Function onFailure})async{

      FirebaseAuth.instance.createUserWithEmailAndPassword(email: userMap['email'], password: userMap['pass']).then((result) async {
        _firebaseUser = result.user;
        userMap.addAll({'id':_firebaseUser.uid,'promotionId': idGenerator()});

        FireUserModel.saveUserDataBasic(userMap: userMap);
        loadData();
        onSucess();
      })
          .catchError((error){
        onFailure(errorAuth(error));
      })
      ;
    }

    signOut()async{
      if(await isLogged())
        await _firebaseAuth.signOut();
        _firebaseUser = null;
        print("Logout!");
    }


    loadData()async{
      if (_firebaseUser == null){
        _firebaseUser = await _firebaseAuth.currentUser();
      }else{
        UserData userData = await FireUserModel.loadUserData(uid: _firebaseUser.uid);
        setUser.add(userData);
      }
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

String errorAuth(PlatformException e) {
  PlatformException error = e;

  if (Platform.isAndroid) {
    switch (error.message) {
      case 'There is no user record corresponding to this identifier. The user may have been deleted.':
        return "Este usuário foi deletado ou não existe.";
        break;
      case 'The password is invalid or the user does not have a password.':
        return "A senha é inválida ou o usuário não possui uma senha.";
        break;
      case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
        return "Tempo de resposta excedido, problemas com a internet.";
        break;
      case 'The email address is already in use by another account.':
        return "Já existe uma conta associada a este email.";
        break;
      case 'Deu ruim! :(':
        return "Deu ruim! :(";
        break;
      case 'Porque cancelou?! ¬¬':
        return "Porque cancelou?! ¬¬";
        break;
      case 'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.':
        return "Jà existe uma conta com o mesmo e-mail vinculado ao seu facebook.";
        break;

    // ...
      default:
        return 'Houve um problema, Entre em contato com o suporte.';
    }
  } else if (Platform.isIOS) {
    switch (error.code) {
      case 'Error 17011':
        return "Este usuário foi deletado ou não existe.";
        break;
      case 'Error 17009':
        return "A senha que voce digitou é inválida para este usuário.";
        break;
      case 'Error 17020':
        return "Tempo de resposta excedido, problemas com a internet.";
        break;
      case '00x1':
        return "Deu ruim! :(";
        break;
      case '00x2':
        return "Porque cancelou?! ¬¬";
        break;
    // ...
      default:
        return "Houve um problema, Entre em contato com o suporte.";
    }
  }
}