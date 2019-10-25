import 'package:birmex/core/models/userModel.dart';
import 'package:birmex/core/viewModels/crudUserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ProfilePage extends StatelessWidget {
  //inctancia del usuario logeado con firebase
    FirebaseUser user;
    //parametro del teléfono
    String phone;
  //contructor
  ProfilePage({this.user,this.phone}); 

  @override
  Widget build(BuildContext context) {
    
    
    
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 42, 86,1.0),
        title: Image.asset("assets/icons/birmex.png"),
      ),
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4,),
                  _buildProfileImage(),
                  _buildFullname(),
                  SizedBox(
                    height: 30.0,
                  ),
                  _buildCardPhone(),
                  _buildCardEmail(),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    
  }


  //Widget sobre el fondo de imagen
  Widget _buildCoverImage(Size screenSize){
    return Container(
      height: screenSize.height / 2.6,
      decoration: new BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/house.png'),
          fit: BoxFit.cover
        ),
      ),
    );
  }
  //Widget para contruir la imagen para el usuario
  Widget _buildProfileImage(){
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: new BoxDecoration(
          color: Color.fromRGBO(25, 42, 86,1.0),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 8.0
          )
        ),
        child:Center(
          child: Text(user.displayName.substring(0,1).toUpperCase(),style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 60.0,
        ),),
        ),
        
      ),
    );
  }

  //widget para el nombre completo
  Widget _buildFullname(){
    TextStyle _nameTextStyle = TextStyle(
      color: Colors.white,
      fontSize: 28.0,
      fontWeight: FontWeight.w700, 
    );

    //regresa el texto
    return Text(user.displayName,
    style: _nameTextStyle,
    );
  }
  //Widget para los datos del usuario
  Widget _buildCardPhone(){
    return Padding(
    padding: EdgeInsets.all(8.0),
    child: Card(
      elevation: 4.0,
      color: Color.fromRGBO(25, 42, 86,1.0),
      child: Container(
      color: Color.fromRGBO(25, 42, 86,1.0),
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
      child: 
      Row(
        children: <Widget>[
          Icon(Icons.phone, color: Colors.white,),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(phone, style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),),
          )
          
        ],
      ),
    ),
    ),
    );
  }
  //Widget para los datos del usuario
  Widget _buildCardEmail(){
    return Padding(
    padding: EdgeInsets.all(8.0),
    child: Card(
      elevation: 4.0,
      color: Color.fromRGBO(25, 42, 86,1.0),
      child: Container(
      color: Color.fromRGBO(25, 42, 86,1.0),
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25.0),
      child: 
      Row(
        children: <Widget>[
          Icon(Icons.email, color: Colors.white,),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(user.email, style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),),
          )
          
        ],
      ),
    ),
    ),
    );
  }
}