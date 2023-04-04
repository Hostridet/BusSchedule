import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:front/repository/BusRepository.dart';
import 'package:front/repository/RoadRepository.dart';
import 'package:front/repository/ScheduleRepository.dart';
import 'package:meta/meta.dart';

import '../../models/Bus.dart';
import '../../models/Road.dart';
import '../../models/Schedule.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _scheduleRepository;
  ScheduleBloc(this._scheduleRepository) : super(ScheduleInitial()) {
    on<GetScheduleEvent>((event, emit) async {
      emit(ScheduleLoadingState());
      try {
        RoadRepository roadRepository = RoadRepository();
        BusRepository busRepository = BusRepository();
        List<Schedule> scheduleList = await _scheduleRepository.getAllSchedule();
        List<Road> roadList = await roadRepository.getAllRoad();
        List<Bus> busList = await busRepository.getAllBusType();
        print(scheduleList);
        emit(ScheduleLoadedState(scheduleList, roadList, busList));
      }
      catch (e) {
        emit(ScheduleErrorState(e.toString()));
      }
    });

    on<AddScheduleEvent>((event, emit) async {
      Schedule schedule = Schedule(id: await _scheduleRepository.getCount(), bus: event.bus, road: event.road,
          cost: event.cost, date: event.date, startTime: event.startTime, endTime: event.endTime);
      schedule.save();
      add(GetScheduleEvent());
    });

    on<DeleteScheduleEvent>((event, emit) async {
      event.schedule.delete();
      add(GetScheduleEvent());
    });
  }
}
