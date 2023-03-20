import 'package:shared_preferences/shared_preferences.dart';

class Bus {
  int id;
  String number;
  String busType;
  Bus({
    required this.id,
    required this.number,
    required this.busType
  });
  void save() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "${id.toString()}/$number/$busType";
    await prefs.setString('bus + ${id.toString()}', savedString);
  }
  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "-1/$number/$busType";
    await prefs.setString('bus + ${id.toString()}', savedString);
  }
  static Future<Bus> getById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? value;
    prefs.getString("bus + ${id.toString()}") != null
        ? value = prefs.getString("bus + ${id.toString()}")
        : value = "0/null/null";
    List<String> valueList = value!.split("/");
    return (Bus(
      id: int.parse(valueList[0]),
      number: valueList[1],
      busType: valueList[2],
    ));
  }
}