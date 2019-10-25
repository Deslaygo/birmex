import 'package:birmex/core/models/terrenoModel.dart';
import 'package:birmex/core/viewModels/crudTerrenoModel.dart';
import 'package:birmex/ui/widgets/terrenoCardAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TerrenosListPage extends StatefulWidget {

  _TerrenosListPageState createState() => _TerrenosListPageState();
}

class _TerrenosListPageState extends State<TerrenosListPage> {

  //lista de terreno
  List<Terreno> terrenos;
  

  @override
  Widget build(BuildContext context) {
    //provider
  final terrenoProvider = Provider.of<CrudTerrenoModel>(context);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: terrenoProvider.fetchTerrenosAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasData) {
              terrenos = snapshot.data.documents.map((doc) =>Terreno.fromMap(doc.data, doc.documentID)).toList();
              return ListView.builder(
                itemCount: terrenos.length,
                itemBuilder: (buildContext, index) => TerrenoCardAdmin(terrenoDetails: terrenos[index],),
              );
            }else{
              return Text("Cargando...");
            }
          },
        ),
      ),
    );
  }
}