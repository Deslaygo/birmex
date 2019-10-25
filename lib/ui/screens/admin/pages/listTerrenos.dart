import 'package:birmex/core/models/terrenoModel.dart';
import 'package:birmex/core/viewModels/crudTerrenoModel.dart';
import 'package:birmex/ui/screens/admin/terreno/addTerreno.dart';
import 'package:birmex/ui/widgets/terrenoCardAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        child: Icon(Icons.add_circle,),
        backgroundColor: Color.fromRGBO(39, 174, 96,1.0),
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (_) => AddTerreno(),
          ));
        },
      ),
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
              return Center(child:SpinKitFadingCube(color: Color.fromRGBO(25, 42, 86,1.0),));
            }
          },
        ),
      ),
    );
  }
}