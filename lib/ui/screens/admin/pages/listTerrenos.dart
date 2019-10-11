import 'package:flutter/material.dart';

class TerrenosListPage extends StatefulWidget {
  TerrenosListPage({Key key}) : super(key: key);

  _TerrenosListPageState createState() => _TerrenosListPageState();
}

class _TerrenosListPageState extends State<TerrenosListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(
         child: Text("Lista de terrenos admin"),
       ),
    );
  }
}