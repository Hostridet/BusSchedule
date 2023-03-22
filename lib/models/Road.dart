import 'package:shared_preferences/shared_preferences.dart';

class Road {
  int id;
  String startCity;
  String endCity;
  Road({
    required this.id,
    required this.startCity,
    required this.endCity,
  });
  void save() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "${id.toString()}/$startCity/$endCity";
    await prefs.setString('road + ${id.toString()}', savedString);
  }
  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "-1/$startCity/$endCity";
    await prefs.setString('road + ${id.toString()}', savedString);
  }
  static Future<Road> getById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? value;
    prefs.getString("road + ${id.toString()}") != null
        ? value = prefs.getString("road + ${id.toString()}")
        : value = "0/null/null";
    List<String> valueList = value!.split("/");
    return (Road(
      id: int.parse(valueList[0]),
      startCity: valueList[1],
      endCity: valueList[2],
    ));
  }
}