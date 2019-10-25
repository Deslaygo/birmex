import 'package:birmex/core/models/terrenoModel.dart';
import 'package:birmex/ui/screens/admin/terreno/TerrenoDetails.dart';
import 'package:flutter/material.dart';

class TerrenoCardAdmin extends StatelessWidget {
  //instancia de terreno
  Terreno terrenoDetails;
  //constructor
  TerrenoCardAdmin({@required this.terrenoDetails});

  //uri de la image

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => TerrenoDetails(terreno: terrenoDetails,),
        ));
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Container(
             height: MediaQuery.of(context).size.height * 0.40,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Hero(
                tag: terrenoDetails.id,
                child: Image.network(terrenoDetails.imagen,
                fit: BoxFit.cover,
                ),
                ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0,bottom: 10.0),
                  child: Container(
                  height: 0.5,
                  color: Color.fromRGBO(25, 42, 86, 1.0),
                ),
                ),
                 Padding(
                  padding: EdgeInsets.only(top:10.0,left: 10.0,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(terrenoDetails.titulo,style: TextStyle(
                        color: Color.fromRGBO(25, 42, 86, 1.0),
                        fontSize: 25.0,
                      ),),
                      
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0,),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.fullscreen, color: Color.fromRGBO(25, 42, 86, 1.0),),
                            Text(terrenoDetails.medidas, style: TextStyle(
                              color: Color.fromRGBO(25, 42, 86, 1.0),
                              fontSize: 20.0,
                            ),),
                          ],
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(left: 5.0,),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.monetization_on, color: Color.fromRGBO(251, 197, 49,1.0),),
                            Text(terrenoDetails.precio, style: TextStyle(
                              color: Color.fromRGBO(25, 42, 86, 1.0),
                              fontSize: 20.0,
                            ),),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only( bottom: 5.0, left: 5.0,),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: Color.fromRGBO(25, 42, 86, 1.0),),
                            Text(terrenoDetails.ubicacion, style: TextStyle(
                              color: Color.fromRGBO(25, 42, 86, 1.0),
                              fontSize: 20.0,
                            ),),
                          ],
                        ),
                      ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}