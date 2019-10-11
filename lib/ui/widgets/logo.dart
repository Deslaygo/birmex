import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final DecorationImage image;
  //constructor
  Logo({this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
      width: 250.0,
      height: 250.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: image,
      ),
    ),
    );
  }
}