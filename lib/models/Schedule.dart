import 'package:shared_preferences/shared_preferences.dart';

class Schedule {
  int id;
  String bus;
  String road;
  int cost;
  String date;
  String startTime;
  String endTime;
  Schedule({
    required this.id,
    required this.bus,
    required this.road,
    required this.cost,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
  void save() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "${id.toString()}/$bus/$road/${cost.toString()}/$date/$startTime/$endTime";
    await prefs.setString('schedule + ${id.toString()}', savedString);
  }
  void delete() async {
    final prefs = await SharedPreferences.getInstance();
    String savedString = "-1/$bus/$road/${cost.toString()}/$date/$startTime/$endTime";
    await prefs.setString('schedule + ${id.toString()}', savedString);
  }
  static Future<Schedule> getById(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? value;
    prefs.getString("schedule + ${id.toString()}") != null
        ? value = prefs.getString("schedule + ${id.toString()}")
        : value = "0/null/null/0/null/null/null";
    List<String> valueList = value!.split("/");
    print(value);
    return (Schedule(
      id: int.parse(valueList[0]),
      bus: valueList[1],
      road: valueList[2],
      cost: int.parse(valueList[3]),
      date: valueList[4],
      startTime: valueList[5],
      endTime: valueList[6],
    ));
  }
}