import 'dart:async';
import 'package:birmex/core/models/terrenoModel.dart';
import 'package:birmex/core/services/apiTerreno.dart';
import 'package:birmex/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudTerrenoModel extends ChangeNotifier{
  //instancia de la api 
  ApiTerreno _api = locator<ApiTerreno>();
  //lista de terrenos
  List<Terreno> terrenos;

  //Método para enlazar los terrenos
  Future<List<Terreno>> fetchTerrenos()async{
    var result = await _api.getDataCollection();
    terrenos = result.documents.map((doc) => Terreno.fromMap(doc.data, doc.documentID)).toList();
    return terrenos;
  }
  //Método par obtener los productos como stream
  Stream<QuerySnapshot> fetchTerrenosAsStream(){
    return _api.streamDataCollection();
  }
  //Método para obtener un terreno por su id
  Future<Terreno> getTerrenoById(String id)async{
    var doc = await _api.getDocumentById(id);
    return Terreno.fromMap(doc.data, doc.documentID);
  }
  //Método para eliminar un terreno
  Future removeTerreno(String id) async{
    await _api.removeDocument(id);
    return ;
  }
  //Método para actualizar un terreno
  Future updateTerreno(Terreno data, String id)async{
    await _api.updateDocument(data.toJson(), id);
    return ;
  }
  //Método para agregar un terreno
  Future addTerreno(Terreno data) async{
    var result = await _api.addDocument(data.toJson());
    return ;
  }
}