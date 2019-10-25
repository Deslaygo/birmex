import 'package:flutter/material.dart';

class EmpresaInfoPage extends StatefulWidget {
  EmpresaInfoPage({Key key}) : super(key: key);

  _EmpresaInfoPageState createState() => _EmpresaInfoPageState();
}

class _EmpresaInfoPageState extends State<EmpresaInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              child: Image.asset("assets/icons/birmex.png"),
            )
          ],
        ),
      ),
    );
  }
}