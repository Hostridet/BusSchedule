import 'package:floor/floor.dart';
import '../entity/BusType.dart';
import 'package:floor/floor.dart';

@dao
abstract class BusTypeDao{
  @Query('SELECT * FROM BusType')
  Stream<List<BusType>> getAllBus();

  @Query('SELECT * FROM BusType WHERE id=:id')
  Stream<BusType?> getBusById(int id);

  @insert
  Future<void> insertBusType(BusType bus);

  @update
  Future<void> updateBus(BusType bus);

  @delete
  Future<void> deleteBus(BusType bus);
}