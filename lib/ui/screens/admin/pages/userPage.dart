import 'package:birmex/core/services/authService.dart';
import 'package:birmex/core/viewModels/crudUserModel.dart';
import 'package:birmex/ui/pages/preguntasPage.dart';
import 'package:birmex/ui/pages/profile.dart';
import 'package:birmex/ui/screens/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  //instancia de un objeto user de firebase
  final FirebaseUser user;
  String telefono ="";
  //contructor
  UserPage({this.user});

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  
  @override
  Widget build(BuildContext context) {
    //variable para el manejo de la db
    var userProvider = Provider.of<CrudUserModel>(context);
    var authProvider = Provider.of<AuthService>(context);
    
    return Scaffold(
      body: ListView(
    children: ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          leading: Icon(Icons.person,color: Color.fromRGBO(25, 42, 86,1.0),),
          title: Text(widget.user.displayName,style: TextStyle(
            color: Color.fromRGBO(25, 42, 86,1.0),
            fontSize: 20,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right,color: Color.fromRGBO(25, 42, 86,1.0),),
          onTap: (){
            String id = widget.user.uid;
            Firestore.instance.collection("users").document(id).get().then((data){
                widget.telefono = data["phone"];
                 print("Telefono:" + widget.telefono);
                 Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProfilePage(user: widget.user,phone: widget.telefono,),
            ));
            });
          },
        ),
        (widget.user.email == "admin456@birmex.com") ?
        ListTile(
          leading: Icon(Icons.people,color: Color.fromRGBO(25, 42, 86,1.0),),
          title: Text("Usuarios",style: TextStyle(
            color: Color.fromRGBO(25, 42, 86,1.0),
            fontSize: 20,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right,color: Color.fromRGBO(25, 42, 86,1.0),),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PreguntasPage(),
            ));
          },
        ):SizedBox(height: 1.0),
         
        ListTile(
          leading: Icon(Icons.help,color: Color.fromRGBO(25, 42, 86,1.0),),
          title: Text("Preguntas frecuentes",style: TextStyle(
            color: Color.fromRGBO(25, 42, 86,1.0),
            fontSize: 20,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right,color: Color.fromRGBO(25, 42, 86,1.0),),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PreguntasPage(),
            ));
          },
        ),
        ListTile(
          leading: Icon(Icons.lock_open,color: Color.fromRGBO(192, 57, 43,1.0),),
          title: Text("Cerrar sesión",style: TextStyle(
            color: Color.fromRGBO(192, 57, 43,1.0),
            fontSize: 20,
          ),),
          trailing: Icon(Icons.minimize,color: Color.fromRGBO(192, 57, 43,1.0),),
          onTap: () async{
            await authProvider.logout();
            print("sesión cerrada");
              Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (_) => LoginScreen(),
            ));
            
          },
        ),
        ListTile(
          leading: Icon(Icons.delete_outline,color: Color.fromRGBO(192, 57, 43,1.0),),
          title:Text("Eliminar cuenta",style: TextStyle(
            color: Color.fromRGBO(192, 57, 43,1.0),
            fontSize: 20,
          ),),
          trailing: Icon(Icons.minimize,color: Color.fromRGBO(192, 57, 43,1.0),),
        ),
        ListTile(
          leading: Icon(Icons.info,color: Color.fromRGBO(25, 42, 86,1.0),),
          title: Text("Sobre la app",style: TextStyle(
            color: Color.fromRGBO(25, 42, 86,1.0),
            fontSize: 20,
          ),),
          trailing: Icon(Icons.keyboard_arrow_right,color: Color.fromRGBO(25, 42, 86,1.0),),
        )
      ]
    ).toList(),
  )
    );
  }
}


