import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder{
  //parametro del widget a ir
  final Widget widget;
  //Parametro por Constructor
  SlideRightRoute({this.widget}):super(
    pageBuilder: (BuildContext context,Animation<double> animation, Animation<double> secondaryanimation){
      return widget;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
      return new SlideTransition(
        position: new Tween<Offset>(
          begin:const Offset(-1.0, 0.0) ,
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    }
  );
}