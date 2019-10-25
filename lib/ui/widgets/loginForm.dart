import 'package:birmex/ui/screens/admin/homeTabs.dart';
import 'package:birmex/ui/screens/homeTabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//Instancia para el logeo con la base de datos
FirebaseAuth _auth = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  

  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //Llave global para la validación del fromulario
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  //controladores para los campos de texto 
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                     obscureText:false,
                     keyboardType: TextInputType.emailAddress,
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
                     obscureText:true,
                     keyboardType: TextInputType.text,
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
                                'Iniciar sesión',
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
                            _signInEmail();
                          },
                        ),
                 
               ],
             ),
           ),
         ],
       ),
    );
  }

  //Método de login 
  void _signInEmail() async{
    if (_formKey.currentState.validate()) {
      //no hay error en la validación
      _formKey.currentState.save();
      //Se intenta hacer el login con los datos 
      FirebaseUser user;
      try {
          user = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text
        );

        //se valida que el usuario trae algo para mandarlo a la vista home
        if (user != null) {
          if(user.email == "admin456@birmex.com"){
            print("admin");
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (_) => HomeTabsAdmin(user: user,),
            ));
            //Navigator.pushReplacementNamed(context,"/homeAdmin");
          }else{
            Navigator.pushReplacement(context,new MaterialPageRoute(
            builder: (_) => HomeTabs(user: user,),
          ));
          }
        } 
        
      } catch (error) {
        //validación de los errores
        switch (error) {
          case "ERROR_USER_NOT_FOUND":
          {
            showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text("Usuario no encontrado, intente de nuevo."),
                        ),
                      );
                    });
          }
            break;
            case "ERROR_WRONG_PASSWORD":
          {
            showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text("La contraseña no coincide con el correo, intente de nuevo"),
                        ),
                      );
                    });
          }
            break;
          default:
        }
      } finally{
        
      }
    } else {
      setState(() {
       _autovalidate = true; 
      });
    }
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