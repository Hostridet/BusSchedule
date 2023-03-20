
import '../models/Bus.dart';

class BusRepository {
  Future<void> delete(Bus bus) async {
    return bus.delete();
  }
  Future<List<Bus>> getAllBusType() async {
    bool flag = false;
    List<Bus> busList = [];
    int index = 0;
    while (flag != true) {
      Bus curBus = await Bus.getById(index);
      if (curBus.number == "null") {
        flag = true;
      }
      else {
        if (curBus.id != -1) {
          busList.add(curBus);
        }
        index++;
      }
    }
    return busList;
  }
  Future<int> getCount() async {
    int index = 0;
    bool flag = false;
    while(flag == false) {
      Bus curBus = await Bus.getById(index);
      if (curBus.number == "null") {
        flag = true;
      }
      else {
        index++;
      }
    }
    return index;
  }
}