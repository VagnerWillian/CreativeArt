import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAndRegister implements BlocBase {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  StorageReference _firebaseStorage = FirebaseStorage.instance.ref();
  Firestore _firestoreRef = Firestore.instance;

  /*final StreamController<List<bool>> _loadingController = StreamController.broadcast();
  Stream get getLoading => _loadingController.stream;
  Sink get setLoading => _loadingController.sink;
*/

  LoginAndRegister(){
    loadData();
  }

  @override
  void dispose() {

  }

  bool getLoggedStatus(){
    if (_firebaseAuth == null){
      return false;
    }else{
      return true;
    }
  }

  loginWithEmail({@required String email, @required String pass, @required Function onSucess, @required onFailure})async{



  }

    SignUp({@required String email, @required String pass, @required VoidCallback onSucess, @required Function onFailure})async{

      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass).then((result) async {
        _firebaseUser = result.user;

        onSucess();
      })
          .catchError((error){
        onFailure(errorAuth(error));
      })
      ;
    }

    signOut()async{
      if(getLoggedStatus())
        _firebaseAuth.signOut();
        _firebaseUser = null;
    }


    loadData()async{
      if (_firebaseUser == null)
        _firebaseUser = await _firebaseAuth.currentUser();
        //if(_firebaseUser != null)
        //await _firestoreRef.collection("administradores").document(_firebaseUser.uid).get().then((userData){
    //  });
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