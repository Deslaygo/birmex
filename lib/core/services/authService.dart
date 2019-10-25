import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Método para obtener al usuario actual 
  Future<FirebaseUser> getUser(){
    return _auth.currentUser();
  }
  //Método para cerrar sesión
  Future logout() async{
    var result = FirebaseAuth.instance.signOut();
    notifyListeners();
    return result;
  }
}