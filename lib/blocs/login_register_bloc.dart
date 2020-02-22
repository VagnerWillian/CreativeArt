import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:call_to_all/data/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAndRegister implements BlocBase {
  List<User> users = [];

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser _firebaseUser;
  StorageReference _firebaseStorage = FirebaseStorage.instance.ref();
  Firestore _firestoreRef = Firestore.instance;
  User user;

  final StreamController<List<bool>> _loadingController = StreamController.broadcast();
  Stream get getLoading => _loadingController.stream;
  Sink get setLoading => _loadingController.sink;

  final StreamController<User> _UserDataController = StreamController.broadcast();
  Stream get getUserData => _UserDataController.stream;
  Sink get setUserData => _UserDataController.sink;

  final StreamController<List<User>> _userLocalData = StreamController.broadcast();
  Stream get getUserLocalData => _userLocalData.stream;
  Sink get setUserLocalData => _userLocalData.sink;

  final StreamController<int> getEmailRecovery = StreamController.broadcast();
  Sink get setEmailRecovery => getEmailRecovery.sink;

  LoginAndRegister(){
    user = User(nome: "", nasc: "", cargo: "", email: "", image: "", uid: "");
    loadLocalData();
  }

  loadLocalData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      final _jsonDecode = json.decode(prefs.getString("usersSaves"));
      int _count = 0;
      while(_jsonDecode[_count]!=null){
        Map<String, dynamic> _userMap = {
          "email":_jsonDecode[_count]['email'],
          "pass":_jsonDecode[_count]['pass'],
          "image":_jsonDecode[_count]['image'],
        };
        User _user = User.fromMap(userMap: _userMap);
        users.add(_user);
        _count += 1;
      }
      setUserLocalData.add(users);
    }catch(e){}
  }

  deleteLocalData({@required User user}){
    users.remove(user);
    saveLocalData();
  }

  bool existLocalData({@required String email}){
    var _userExist = users.where((user)=>user.email == email);
    return _userExist.length != 0;
  }

  addLocalData({@required String email, @required String pass, @required String image}){
    var _userExist = users.where((user)=>user.email == email);
    if(_userExist.length == 0){
      Map<String, dynamic> _userMap = {
        "email": email,
        "pass": pass,
        "image": image,
      };
      User _user = User.fromMap(userMap: _userMap);
      users.add(_user);
      saveLocalData();
    }
  }

  saveLocalData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> _listMapUser = [];
    for(User _user in users){
      Map<String, dynamic> _userMap = {
        "email":_user.email,
        "image":_user.image
      };
      _listMapUser.add(_userMap);
    }
    String _jsonUserSave = json.encode(_listMapUser);
    prefs.setString("usersSaves", _jsonUserSave);
    setUserLocalData.add(users);
  }

  @override
  void dispose() {
    _loadingController.close();
    _UserDataController.close;
    getEmailRecovery.close();
  }

  bool getLoggedStatus(){
    if (_firebaseAuth != null){
      return true;
    }else{
      return false;
    }
  }


  setUrlImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    final croppedImage = await ImageCrop.sampleImage(
      file: File(image.path),
      preferredWidth: 500,
      preferredHeight: 500,
    );
    user.image = croppedImage.path;
    setUserData.add(user);
  }


  loginWithEmail({@required String email, @required String pass, @required Function onSucess, @required onFailure})async{
    setLoading.add([true, false]);
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass).then((result)async{
      _firebaseUser = result.user;

      await loadData();
      onSucess(); // <- APÓS LOGADO, AQUI ABRIRÁ A TELA PRINCIPAL
      setLoading.add([false, false]);
    })
        .catchError((error){
      onFailure(errorAuth(error));
      setLoading.add([false, false]);
    })
    ;

  }

    SignUp({@required Map<String, dynamic> userMap,@required String pass, @required VoidCallback onSucess, @required Function onFailure})async{
      setLoading.add([false, true]);
      user = User.fromMap(userMap: userMap); // <---- Atribui valores ao usuario
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: pass).then((result) async {
        _firebaseUser = result.user;
        user.uid = _firebaseUser.uid;

        //Armazena imagem de perfil no storage
        await imageUpload(user.image);

        //Envia os dados para o FireStore
        await _firestoreRef.collection("administradores").document(_firebaseUser.uid).setData(user.toMap());

        setLoading.add([false, false]);
        setUserData.add(user);
        user = User(nome: "", nasc: "", cargo: "", email: "", image: "", uid: "");
        onSucess();
      })
          .catchError((error){
        setLoading.add([false, false]);
        onFailure(errorAuth(error));
      })
      ;
    }

    signOut()async{
      if(getLoggedStatus())
        _firebaseAuth.signOut();
        _firebaseUser = null;
        user = User(nome: "", nasc: "", cargo: "", email: "", image: "", uid: "");
        setUserData.add(user);
    }


    loadData()async{
      if (_firebaseUser == null)
        _firebaseUser = await _firebaseAuth.currentUser();
        if(_firebaseUser != null)
        await _firestoreRef.collection("administradores").document(_firebaseUser.uid).get().then((userData){
        user = User.fromMap(userMap: userData.data);
        setUserData.add(user);
      });
    }

    imageUpload(String path) async {
      StorageReference storageReference = _firebaseStorage.child("administradores").child(user.uid).child("image_profile.jpg");
      StorageUploadTask uploadTask = storageReference.putFile(File(path));
      await uploadTask.onComplete;
      await uploadTask.onComplete.then((result)async{
        user.image = await result.ref.getDownloadURL();
      });

    }

    recoveryPassword(String email)async{
      setEmailRecovery.add(0);
      await Future.delayed(Duration(seconds: 2)); //CODIGO QUE ENVIA EMAIL DE RECUPERAÇÃO PARA O USUARIO
      print("Um email foi enviado para o usuario");
      //setEmailRecovery.add("Enviado!");
      print(enviaEmailTeste());
    }

   int enviaEmailTeste(){
        return Random(3).nextInt(3);
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