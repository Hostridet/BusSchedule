
import '../models/City.dart';

class CityRepository {
  Future<void> delete(City city) async {
    return city.delete();
  }

  Future<List<City>> getAllCity() async {
    bool flag = false;
    List<City> cityList = [];
    int index = 0;
    while (flag != true) {
      City curCity = await City.getSoilById(index);
      if (curCity.name == "null") {
        flag = true;
      }
      else {
        if (curCity.id != -1) {
          cityList.add(curCity);
        }
        index++;
      }
    }
    return cityList;
  }

  Future<int> getCount() async {
    int index = 0;
    bool flag = false;
    while(flag == false) {
      City curCity = await City.getSoilById(index);
      if (curCity.name == "null") {
        flag = true;
      }
      else {
        index++;
      }
    }
    return index;
  }
}