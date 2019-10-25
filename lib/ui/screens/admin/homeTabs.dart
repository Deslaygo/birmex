import 'package:birmex/ui/screens/admin/pages/listTerrenos.dart';
import 'package:birmex/ui/screens/admin/pages/empresaInfo.dart';
import 'package:birmex/ui/screens/admin/pages/userPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeTabsAdmin extends StatefulWidget {
  //instancia del objeto user pasado por parametro
  final FirebaseUser user;
  //contructor
  HomeTabsAdmin({this.user});

  _HomeTabsAdminState createState() => _HomeTabsAdminState();
}

class _HomeTabsAdminState extends State<HomeTabsAdmin> with SingleTickerProviderStateMixin {
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
          UserPage(user: widget.user,),
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
             text: "Inicio",
             icon: Icon(Icons.home),
           ),
           new Tab(
             text: "Nosotros",
             icon: Icon(Icons.location_city),
           ),
           new Tab(
             text: "Opciones",
             icon: Icon(Icons.list),
           ),
         ],
        ),
      ) ,
    );
  }
}