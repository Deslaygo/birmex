import 'package:birmex/core/models/userModel.dart';
import 'package:birmex/core/services/apiUser.dart';
import 'package:birmex/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CrudUserModel extends ChangeNotifier{
  //intancia de la api
  ApiUser _apiUser = locator<ApiUser>();
  //lista de usuarios
  List<User> usuarios;
  //Método para enlazar los usuarios
  Future<List<User>> fetchUsers()async{
    var result = await _apiUser.getDataCollection();
    usuarios = result.documents.map((doc) => User.fromMap(doc.data, doc.documentID));
    return usuarios;
  }
  //Método para obtener los usuarios como stream
  Stream<QuerySnapshot> fetchAsStreamUsers(){
    return _apiUser.streamDataCollection();
  }
  //Método para obtener un usuario pos su id 
  Future<User> getUserById(String id) async{
    var doc =  await _apiUser.getDocumentById(id);
    return User.fromMap(doc.data, doc.documentID);
  }
  //Método para eliminar un usuario
  Future removeUser(String id) async{
    await _apiUser.removeDocument(id);
    return;
  }
  //Método para agregar un usuario
  Future addUser(User data)async{
    var result = await _apiUser.addDocument(data.toJson());
    return;
  }
}