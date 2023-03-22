
import '../models/Road.dart';

class RoadRepository {
  Future<void> delete(Road road) async {
    return road.delete();
  }
  Future<List<Road>> getAllRoad() async {
    bool flag = false;
    List<Road> roadList = [];
    int index = 0;
    while (flag != true) {
      Road curRoad = await Road.getById(index);
      if (curRoad.startCity == "null") {
        flag = true;
      }
      else {
        if (curRoad.id != -1) {
          roadList.add(curRoad);
        }
        index++;
      }
    }
    return roadList;
  }
  Future<int> getCount() async {
    int index = 0;
    bool flag = false;
    while(flag == false) {
      Road curRoad = await Road.getById(index);
      if (curRoad.startCity == "null") {
        flag = true;
      }
      else {
        index++;
      }
    }
    return index;
  }
}