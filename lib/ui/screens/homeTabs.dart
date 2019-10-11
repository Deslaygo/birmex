import 'package:birmex/ui/screens/Empresa/empresaInfo.dart';
import 'package:birmex/ui/screens/Terrenos/listTerrenos.dart';
import 'package:birmex/ui/screens/Usuario/userPage.dart';
import 'package:flutter/material.dart';

class HomeTabs extends StatefulWidget {
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> with SingleTickerProviderStateMixin {
  //Declaración del tab control
  TabController homeTabController;

  //Se inicializa el tab controller
  @override
  void initState() {
    super.initState();
    homeTabController = new TabController(length: 3,vsync: this);
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 42, 86,1.0),
        title: Image.asset("assets/icons/birmex.png"),
      ),
      body:TabBarView(
        controller: homeTabController,
        children: <Widget>[
          TerrenosListPage(),
          EmpresaInfoPage(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: Material(
        color:Color.fromRGBO(25, 42, 86,1.0),
        child: TabBar(
          labelColor: Color.fromRGBO(251, 197, 49,1.0),
          indicatorColor: Color.fromRGBO(251, 197, 49,1.0),
         unselectedLabelColor: Colors.white,
         controller: homeTabController,
         tabs: <Tab>[
           new Tab(
             icon: Icon(Icons.home),
           ),
           new Tab(
             icon: Icon(Icons.info_outline),
           ),
           new Tab(
             icon: Icon(Icons.verified_user),
           ),
         ],
        ),
      ) ,
    );
  }
}