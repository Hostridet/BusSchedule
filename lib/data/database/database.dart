import 'package:floor/floor.dart';
import 'package:front/data/entity/BusType.dart';
import '../dao/BusDao.dart';
import '../dao/BusTypeDao.dart';
import '../entity/bus.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version:2, entities:[Bus, BusType])
abstract class AppDataBase extends FloorDatabase {
  BusDao get busDao;
  BusTypeDao get busTypeDao;
}