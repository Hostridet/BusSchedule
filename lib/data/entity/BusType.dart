import 'package:floor/floor.dart';

@entity
class BusType {
  @PrimaryKey(autoGenerate: true)
  final int id;
  String type;
  final int range;

  BusType({required this.id, required this.type, required this.range});
}