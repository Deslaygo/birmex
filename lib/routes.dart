import 'package:birmex/core/services/authService.dart';
import 'package:birmex/locator.dart';
import 'package:birmex/ui/screens/homeTabs.dart';
import 'package:birmex/ui/screens/admin/homeTabs.dart';
import 'package:birmex/ui/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/viewModels/crudTerrenoModel.dart';
import 'core/viewModels/crudUserModel.dart';

class Routes{
  Routes(){
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CrudTerrenoModel>()),
        ChangeNotifierProvider(builder: (_) => locator<CrudUserModel>()),
        ChangeNotifierProvider(builder: (_) => locator<AuthService>(),)
      ],
    child:
    MaterialApp(
      title: 'Birmex',
      home: LoginScreen(),
     routes: {
       "/homeAdmin": (_) => HomeTabsAdmin(),
     },
    )),);
  }
}
