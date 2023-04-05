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
    if (!await findSameValue(startCity, endCity)) {
      await prefs.setString('road + ${id.toString()}', savedString);

    }
  }
  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "-1/$startCity/$endCity";
    await prefs.setString('road + ${id.toString()}', savedString);
  }
  static Future<void> deleteConnectedRoad(String city) async {
    int index = 0;
    bool flag = false;
    while (flag != true) {
      Road curRoad = await Road.getById(index);
      if (curRoad.startCity == "null") {
        flag = true;
      }
      else {
        if (curRoad.id != -1) {
          if (curRoad.startCity == city || curRoad.endCity == city) {
            curRoad.delete();
          }
        }
        index++;
      }
    }

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
  Future<bool> findSameValue(String start, String end) async {
    bool flag = false;
    int index = 0;
    while (flag != true) {
      Road curRoad = await Road.getById(index);
      if (curRoad.startCity == "null") {
        flag = true;
      }
      else {
        if (curRoad.id != -1) {
          if (curRoad.startCity == start && curRoad.endCity == end) {
            return true;
          }
        }
        index++;
      }
    }
    return false;
  }
}