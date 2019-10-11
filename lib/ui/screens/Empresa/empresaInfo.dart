import 'package:flutter/material.dart';

class EmpresaInfoPage extends StatefulWidget {
  EmpresaInfoPage({Key key}) : super(key: key);

  _EmpresaInfoPageState createState() => _EmpresaInfoPageState();
}

class _EmpresaInfoPageState extends State<EmpresaInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text("Info empresa"),
       ),
    );
  }
}