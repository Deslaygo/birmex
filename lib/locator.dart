import 'package:birmex/core/services/apiUser.dart';
import 'package:birmex/core/viewModels/crudUserModel.dart';
import 'package:get_it/get_it.dart';
import './core/services/apiTerreno.dart';
import './core/viewModels/crudTerrenoModel.dart';
import 'core/services/authService.dart';

GetIt locator = GetIt();

void setupLocator(){
  locator.registerLazySingleton(() => ApiTerreno('terrenos'));
  locator.registerLazySingleton(() => CrudTerrenoModel());
  locator.registerLazySingleton(() => ApiUser('users'));
  locator.registerLazySingleton(() => CrudUserModel());
  locator.registerLazySingleton(() => AuthService());
}