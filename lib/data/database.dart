import 'package:floor/floor.dart';
import 'dao/BusDao.dart';
import 'entity/bus.dart';

@Database(version:1, entities:[Bus])
abstract class AppDataBase extends FloorDatabase {
  BusDao get busDao;
}