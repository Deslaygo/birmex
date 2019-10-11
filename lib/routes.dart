import 'package:birmex/ui/screens/homeTabs.dart';
import 'package:birmex/ui/screens/login/login.dart';
import 'package:flutter/material.dart';

class Routes{
  Routes(){
    runApp(new MaterialApp(
      title: 'Birmex',
      home: LoginScreen(),
      onGenerateRoute: (RouteSettings settings){
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new LoginScreen() ,
              settings: settings,
            );
            break;
            case '/home':
            new MyCustomRoute(
              builder: (_) => new HomeTabs(),
              settings: settings,
            );
            break;
          default:
        }
      },
    ));
  }
}

//Clase para las rutas customizadas
class MyCustomRoute<T> extends MaterialPageRoute<T>{

  //constructor
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings}):super(
    builder: builder,settings:settings);

    @override
    Widget buildTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation,Widget child){
      if(settings.isInitialRoute) return child;
      return new FadeTransition(opacity: animation,child: child);
    }
}