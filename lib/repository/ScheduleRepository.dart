

import 'package:front/models/Schedule.dart';

class ScheduleRepository {
  Future<void> delete(Schedule schedule) async {
    return schedule.delete();
  }
  Future<List<Schedule>> getAllSchedule() async {
    bool flag = false;
    List<Schedule> scheduleList = [];
    int index = 0;
    while (flag != true) {
      Schedule curSchedule = await Schedule.getById(index);
      if (curSchedule.bus == "null") {
        flag = true;
      }
      else {
        if (curSchedule.id != -1) {
          scheduleList.add(curSchedule);
        }
        index++;
      }
    }
    return scheduleList;
  }
  Future<int> getCount() async {
    int index = 0;
    bool flag = false;
    while(flag == false) {
      Schedule curSchedule = await Schedule.getById(index);
      if (curSchedule.bus == "null") {
        flag = true;
      }
      else {
        index++;
      }
    }
    return index;
  }
}