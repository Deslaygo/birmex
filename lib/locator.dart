import 'package:get_it/get_it.dart';
import './core/services/apiTerreno.dart';
import './core/viewModels/crudTerrenoModel.dart';

GetIt locator = GetIt();

void setupLocator(){
  locator.registerLazySingleton(() => ApiTerreno('terrenos'));
  locator.registerLazySingleton(() => CrudTerrenoModel());
}