import 'package:birmex/core/models/terrenoModel.dart';
import 'package:birmex/core/viewModels/crudTerrenoModel.dart';
import 'package:birmex/ui/screens/admin/homeTabs.dart';
import 'package:birmex/ui/screens/admin/terreno/editTerreno.dart' as prefix0;
import 'package:birmex/ui/screens/admin/terreno/editTerreno.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TerrenoDetails extends StatelessWidget {
  //instacia del objeto terreno 
  final Terreno terreno;
  //constructor
  TerrenoDetails({this.terreno});


  @override
  Widget build(BuildContext context) {
    //Provider del terreno
    final terrenoProvider = Provider.of<CrudTerrenoModel>(context);
    return Scaffold(
      appBar: AppBar(
        title:Image.asset("assets/images/logo.png"),
        backgroundColor: Color.fromRGBO(25, 42, 86, 1.0),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever, 
            color: Color.fromRGBO(192, 57, 43,1.0)
            ),
            onPressed: ()async {
              Alert(
                context: context,
                title: "¿Esta seguro de eliminar la información?",
                desc: "Al aceptar, se eliminará toda la información permanentemente",
                image: Image.asset("assets/images/deleteAnimation.gif", fit: BoxFit.cover,),
                buttons: [
                DialogButton(
                  child: Text(
                    "Aceptar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: (){
                    terrenoProvider.removeTerreno(terreno.id);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => HomeTabsAdmin(),
                    ));
                    //eliminar imagen de la base de datos
                    String pathImage = terreno.imagen.replaceAll(new 
                    RegExp(r'https://firebasestorage.googleapis.com/v0/b/birmex-875be.appspot.com/o/'), '').split('?')[0];
                    //se elimina de firebase
                    FirebaseStorage.instance.ref().child(pathImage).delete().then(
                      (_) => print("imagen eliminada"));
                  },
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                ),
                DialogButton(
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.blueGrey,
                )
              ],
              ).show();
            },
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.edit,
            color: Color.fromRGBO(243, 156, 18,1.0),
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => EditTerreno(terreno: terreno),
              ));
            },
          ),
        ],
      ),
      body: 
      Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            child: Hero(
            tag: terreno.id,
            child: Image.network(terreno.imagen,
            fit: BoxFit.cover,
            ),
          ),
          ),
         Container(
           width: MediaQuery.of(context).size.width,
           color: Colors.white10,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
                //Título del terreno
         Container(
           padding: const EdgeInsets.only(left: 10.0),
           child:  Text(terreno.titulo,
          style: TextStyle(
            color: Color.fromRGBO(25, 42, 86, 1.0),
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),
          ),
         ),
          Divider(),
          //Texto sobre la ubicación
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.location_on,
                color:Color.fromRGBO(25, 42, 86, 0.8),
                ),
              ),
               Container(
             padding: const EdgeInsets.only(left: 10.0),
             child: Text(terreno.ubicacion,
            style: TextStyle(
            color: Color.fromRGBO(25, 42, 86, 0.8),
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
          ),
          ),
          ),
            ],
          ),
         Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.monetization_on,
                color:Color.fromRGBO(25, 42, 86, 0.8),
                ),
              ),
               Container(
             padding: const EdgeInsets.only(left: 10.0),
             child: Text(terreno.precio,
            style: TextStyle(
            color: Color.fromRGBO(25, 42, 86, 0.8),
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
          ),
          ),
          ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.fullscreen,
                color:Color.fromRGBO(25, 42, 86, 0.8),
                ),
              ),
               Container(
             padding: const EdgeInsets.only(left: 10.0),
             child: Text(terreno.medidas,
            style: TextStyle(
            color: Color.fromRGBO(25, 42, 86, 0.8),
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
          ),
          ),
          ),
            ],
          ),
          Divider(),
          //Texto sobre la descripcion
            Container(
             padding: const EdgeInsets.only(left: 10.0),
             child: Text("Descripción",
            style: TextStyle(
            color: Color.fromRGBO(25, 42, 86, 1.0),
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
          ),
          ),
            Container(
             padding: const EdgeInsets.only(left: 10.0),
             child: Text(terreno.descripcion,
            style: TextStyle(
            color: Color.fromRGBO(25, 42, 86, 0.8),
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
          ),
          ),
          ),
             ],
           ),
         ),
         
        ],
      ),
    );
  }

 
}