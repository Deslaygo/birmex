import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class  ApiTerreno{
  //instancia de firestore
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;
  //constructor
  ApiTerreno(this.path){
    ref = _db.collection(path);
  }

  //Obtener la coleccion de datos
  Future<QuerySnapshot> getDataCollection(){
    return ref.getDocuments();
  }
  //Obtener un stream de los datos
  Stream<QuerySnapshot> streamDataCollection(){
    return ref.snapshots();
  }
  //obtiene un documento pos su id
  Future<DocumentSnapshot> getDocumentById(String id){
    ref.document(id).get();
  }
  //remover un documento por su id
  Future<void> removeDocument(String id){
    return ref.document(id).delete();
  }
  //agregar documento
  Future<DocumentReference> addDocument(Map data){
    return ref.add(data);
  }
  //actualizar un documento por su id
  Future<void> updateDocument(Map data,String id){
    return ref.document(id).updateData(data);
  }
}