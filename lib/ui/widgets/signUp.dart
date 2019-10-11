import 'package:birmex/ui/animations/slideRightRoute.dart';
import 'package:birmex/ui/screens/register/register.dart';
import 'package:flutter/material.dart';

class SignUpComponent extends StatelessWidget {
  const SignUpComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (new FlatButton(
      padding: const EdgeInsets.only(top: 60.0),
      onPressed: (){
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        ));
      },
      child: Text("¿No tienes una cuenta?, regístrate",
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
        color: Colors.white,
        fontSize: 13.0,
      ),
      ),
    ));
  }
}