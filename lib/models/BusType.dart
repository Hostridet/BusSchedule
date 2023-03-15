import 'package:shared_preferences/shared_preferences.dart';


class BusType {
  int id;
  String type;
  int range;
  BusType({
    required this.id,
    required this.type,
    required this.range
  });

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "${id.toString()}/$type/$range";
    await prefs.setString('busType + ${id.toString()}', savedString);
  }

  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "-1/$type/$range";
    await prefs.setString('busType + ${id.toString()}', savedString);
  }

  static Future<BusType> getSoilById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? value;
    prefs.getString("busType + ${id.toString()}") != null
        ? value = prefs.getString("busType + ${id.toString()}")
        : value = "0/null/0";
    List<String> valueList = value!.split("/");
    return (BusType(
      id: int.parse(valueList[0]),
      type: valueList[1],
      range: int.parse(valueList[2]),
    ));
  }
}