import 'package:front/data/database/database.dart';
import 'package:front/data/entity/BusType.dart';

class BusTypeRepository {
  Future<void> insertBusType(BusType busType) async {
    final database = await $FloorAppDataBase
        .databaseBuilder('flutter_database.db')
        .build();
    final dao = database.busTypeDao;
    dao.insertBusType(busType);
  }

  Future<List<BusType>> getAllBusType() async {
    final database = await $FloorAppDataBase
        .databaseBuilder('flutter_database.db')
        .build();
    final dao = database.busTypeDao;
    List<BusType> listBus = dao.getAllBus() as List<BusType>;
    return listBus;
  }
}