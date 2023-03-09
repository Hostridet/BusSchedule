import 'package:floor/floor.dart';

@entity
class Bus {
  @PrimaryKey(autoGenerate: true)
  final int id;
  String number, classes;

  Bus({required this.id, required this.number, required this.classes});
}