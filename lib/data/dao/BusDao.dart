import 'package:floor/floor.dart';
import '../entity/bus.dart';

@dao
abstract class BusDao{
  @Query('SELECT * FROM Bus')
  Stream<List<Bus>> getAllBus();

  @Query('SELECT * FROM Bus WHERE id=:id')
  Stream<Bus?> getBusById(int id);

  @insert
  Future<void> insertBus(Bus bus);

  @update
  Future<void> updateBus(Bus bus);

  @delete
  Future<void> deleteBus(Bus bus);
}
