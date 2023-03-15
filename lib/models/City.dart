import 'package:shared_preferences/shared_preferences.dart';

class City {
  int id;
  String name;
  City({
    required this.id,
    required this.name
  });

  void safe() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "${id.toString()}/$name";
    await prefs.setString('city + ${id.toString()}', savedString);
  }

  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "-1/$name";
    await prefs.setString('city + ${id.toString()}', savedString);
  }

  static Future<City> getSoilById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? value;
    prefs.getString("city + ${id.toString()}") != null
        ? value = prefs.getString("city + ${id.toString()}")
        : value = "0/null";
    List<String> valueList = value!.split("/");
    return (City(
      id: int.parse(valueList[0]),
      name: valueList[1],
    ));
  }
}