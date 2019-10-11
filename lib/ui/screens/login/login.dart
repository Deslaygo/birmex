import 'package:birmex/ui/screens/login/styles.dart';
import 'package:birmex/ui/widgets/loginForm.dart';
import 'package:birmex/ui/widgets/logo.dart';
import 'package:birmex/ui/widgets/signUp.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: backgroundImage,
          ),
          child: new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  const Color.fromRGBO(39, 60, 117,0.8),
                  const Color.fromRGBO(72, 126, 176,0.9),
                ],
                stops: [0.2,1.0],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              ),),
              child: ListView(
                padding: const EdgeInsets.all(0.0),
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Logo(image: logo,),
                          LoginForm(),
                          SignUpComponent(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
          ),
        ),
      );
  }
}