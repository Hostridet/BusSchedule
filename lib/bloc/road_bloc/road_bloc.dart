import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:front/repository/CityRepository.dart';
import 'package:meta/meta.dart';

import '../../models/City.dart';
import '../../models/Road.dart';
import '../../repository/RoadRepository.dart';

part 'road_event.dart';
part 'road_state.dart';

class RoadBloc extends Bloc<RoadEvent, RoadState> {
  final RoadRepository _roadRepository;
  RoadBloc(this._roadRepository) : super(RoadInitial()) {
    on<GetRoadEvent>((event, emit) async {
      emit(RoadLoadingState());
      try {
        List<Road> roadList = await _roadRepository.getAllRoad();
        CityRepository _cityRepository = CityRepository();
        List<City> cityList = await _cityRepository.getAllCity();
        emit(RoadLoadedState(cityList, roadList));
      }
      catch (e) {
        emit(RoadErrorState(e.toString()));
      }
    });

    on<AddRoadEvent>((event, emit) async {
      Road road = Road(id: await _roadRepository.getCount(), startCity: event.startCity, endCity: event.endCity);
      road.save();
      add(GetRoadEvent());
    });

    on<DeleteRoadEvent>((event, emit) async {
      event.road.delete();
      add(GetRoadEvent());
    });
  }
}
