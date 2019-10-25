import 'package:birmex/ui/screens/homeTabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//instancia de firebase 
final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterForm extends StatefulWidget {

  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  //Global key para el formulario
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  //controllers para los campos de texo y la validación
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  //Variable para la validacion del logeo de usuario
  bool _success;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
       child:new Column(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[
           Form(
             key: _formKey,
             autovalidate: _autovalidate,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[
                 //Caja de texto de nombre completo
                 Container(
                   decoration: new BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         width: 0.5,
                         color: Colors.white,
                       ),
                     ),
                   ),
                   child: new TextFormField(
                     controller: _nombreController,
                     keyboardType: TextInputType.text,
                     validator: _validateName,
                     obscureText:false,
                     style: const TextStyle(
                       color: Colors.white
                     ),
                     decoration: InputDecoration(
                       icon: new Icon(Icons.person_outline,color: Colors.white,),
                       border: InputBorder.none,
                       hintText: "Nombre completo",
                       hintStyle: const TextStyle(
                         color: Colors.white,
                         fontSize: 15.0
                       ),
                       contentPadding: const EdgeInsets.only(top: 30.0,right:30.0,bottom: 30.0,left: 5.0),
                     ),
                   ),
                   
                 ),
                 //Caja de texto de teléfono
                 Container(
                   decoration: new BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         width: 0.5,
                         color: Colors.white,
                       ),
                     ),
                   ),
                   child: new TextFormField(
                     controller: _telefonoController,
                     keyboardType: TextInputType.phone,
                     maxLength: 10,
                     obscureText:false,
                     validator: _validatePhone,
                     style: const TextStyle(
                       color: Colors.white
                     ),
                     decoration: InputDecoration(
                       icon: new Icon(Icons.phone_android,color: Colors.white,),
                       border: InputBorder.none,
                       hintText: "Teléfono",
                       hintStyle: const TextStyle(
                         color: Colors.white,
                         fontSize: 15.0
                       ),
                       contentPadding: const EdgeInsets.only(top: 30.0,right:30.0,bottom: 30.0,left: 5.0),
                     ),
                   ),
                   
                 ),
                 //Caja de texto de email
                 Container(
                   decoration: new BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         width: 0.5,
                         color: Colors.white,
                       ),
                     ),
                   ),
                   child: new TextFormField(
                     controller: _emailController,
                     keyboardType: TextInputType.emailAddress,
                     obscureText:false,
                     validator: _validateEmail,
                     style: const TextStyle(
                       color: Colors.white
                     ),
                     decoration: InputDecoration(
                       icon: new Icon(Icons.person_outline,color: Colors.white,),
                       border: InputBorder.none,
                       hintText: "Email",
                       hintStyle: const TextStyle(
                         color: Colors.white,
                         fontSize: 15.0
                       ),
                       contentPadding: const EdgeInsets.only(top: 30.0,right:30.0,bottom: 30.0,left: 5.0),
                     ),
                   ),
                   
                 ),
                 //Caja de texto de la contraseña
                 Container(
                   decoration: new BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         width: 0.5,
                         color: Colors.white,
                       ),
                     ),
                   ),
                   child: new TextFormField(
                     controller: _passwordController,
                     keyboardType: TextInputType.text,
                     obscureText:true,
                     validator: _validatePass,
                     style: const TextStyle(
                       color: Colors.white
                     ),
                     decoration: InputDecoration(
                       icon: new Icon(Icons.lock_outline,color: Colors.white,),
                       border: InputBorder.none,
                       hintText: "Contraseña",
                       hintStyle: const TextStyle(
                         color: Colors.white,
                         fontSize: 15.0
                       ),
                       contentPadding: const EdgeInsets.only(top: 30.0,right:30.0,bottom: 30.0,left: 5.0),
                     ),
                   ),
                   
                 ),
                //Caja de texto de confirma tu contraseña
                 Container(
                   decoration: new BoxDecoration(
                     border: Border(
                       bottom: BorderSide(
                         width: 0.5,
                         color: Colors.white,
                       ),
                     ),
                   ),
                   child: new TextFormField(
                     controller: _passwordConfirmController,
                     keyboardType: TextInputType.text,
                     validator: (String value){
                       if (value != _passwordController.text) {
                         return "La contraseña no coincide";
                       }
                       return null;
                     },
                     obscureText:true,
                     style: const TextStyle(
                       color: Colors.white
                     ),
                     decoration: InputDecoration(
                       icon: new Icon(Icons.lock_outline,color: Colors.white,),
                       border: InputBorder.none,
                       hintText: "Confirmar contraseña",
                       hintStyle: const TextStyle(
                         color: Colors.white,
                         fontSize: 15.0
                       ),
                       contentPadding: const EdgeInsets.only(top: 30.0,right:30.0,bottom: 30.0,left: 5.0),
                     ),
                   ),
                   
                 ),
                 //Botón de iniciar sesión
                 Padding(
                   padding: const EdgeInsets.only(top: 40.0),
                 ),
                 new RaisedButton(
                          color: const Color.fromRGBO(241, 196, 15,1.0),
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          padding: new EdgeInsets.all(16.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                'Registrarse',
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.5
                                    ),
                              ),
                            ],
                          ),
                          onPressed: (){
                            _regiter();
                          },
                        ),
                 
               ],
             ),
           ),
         ],
       ),
    );
  }
    //Método que valida los campos
  void _regiter() async{
    if (_formKey.currentState.validate()) {
      //No hay error en la validación
      _formKey.currentState.save();
      //Creación del usuario
      FirebaseUser user;
      //se intenta la creación 
      try{
       user = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );
      //Se guardan los demas datos del usuario
     UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = _nombreController.text;
      //se guarda el uid del usuario 
      var uid = user.uid; 
      print(uid);
    
      //actualizacion de la informacion
      user.updateProfile(userUpdateInfo).then((onValue){
        Firestore.instance.collection('users').document(uid).setData({
          'email':_emailController.text, 
          'displayName': _nombreController.text,
          'phone': _telefonoController.text
        }).then((onValue){
        });
      });
      } catch (error) {
        switch (error.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
            showDialog(
              context: context,
              builder: (BuildContext  context){
                return AlertDialog(
                  content: Container(
                    child: Text("Este email ya esta en uso"),
                  ),
                );
              },
            );
            break;
            case "ERROR_WEAK_PASSWORD":
            showDialog(
              context: context,
              builder: (BuildContext  context){
                return AlertDialog(
                  content: Container(
                    child: Text("La contraseña debe contener 7 o más caracteres"),
                  ),
                );
              },
            );
            break;
          default:
        }
      }finally{
        //validación si ya existe el usuario
        if (user != null) {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (_) => HomeTabs(),
          ));
        }
      }

    } else {
      setState(() {
       _autovalidate = true; 
      });
    }
  }
  //Método par validar el nombre
  String _validateName(String value){
    //patter de solo letras
    String pattern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(pattern);
    //validación
    if (value.length == 0) {
      return "Nombre es obligatorio";
    } else if(!regExp.hasMatch(value)){
      return "El nombre debe contener solo letras";
    }
    return null;
  }
  //Método para validar el nombre de teléfono
  String _validatePhone(String value){
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    //validación
    if (value.length == 0) {
      return "Teléfono es obligatorio";
    } else if(value.length != 10){
      return "Teléfono debe contener 10 dígitos";
    }else if (!regExp.hasMatch(value)) {
      return "Teléfono debe contener solo dígitos";
    }
    return null;
  }
  //Método para validar el correo electronico
  String _validateEmail(String value){
    String pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    //validaciones
    if (value.length == 0) {
      return "Email es obligatorio";
    }else if (!regExp.hasMatch(value)) {
      return "Formato de email invalido";
      
    }
  }
  //Método par validar la contraseña
  String _validatePass(String value){
    //validaciones
    if (value.length == 0) {
      return "Contraseña es obligatoria";
    } else if(value.length <= 6){
      return "La contraseña debe contener más de 6 caracteres";
    }
    return null;
  }
}
