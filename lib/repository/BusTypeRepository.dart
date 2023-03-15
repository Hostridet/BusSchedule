import 'package:front/models/BusType.dart';

class BusTypeRepository {
  Future<void> delete(BusType busType) async {
    return busType.delete();
  }

  Future<List<BusType>> getAllBusType() async {
    bool flag = false;
    List<BusType> busTypeList = [];
    int index = 0;
    while (flag != true) {
      BusType curBus = await BusType.getSoilById(index);
      if (curBus.type == "null") {
        flag = true;
      }
      else {
        if (curBus.id != -1) {
          busTypeList.add(curBus);
        }
        index++;
      }
    }
    return busTypeList;
  }

  Future<int> getCount() async {
    int index = 0;
    bool flag = false;
    while(flag == false) {
      BusType curSoil = await BusType.getSoilById(index);
      if (curSoil.type == "null") {
        flag = true;
      }
      else {
        index++;
      }
    }
    return index;
  }
}