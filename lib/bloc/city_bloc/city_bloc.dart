import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/City.dart';
import '../../repository/CityRepository.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository _cityRepository;
  CityBloc(this._cityRepository) : super(CityInitial()) {
    on<GetCityEvent>((event, emit) async {
      emit(CityLoadingState());
      try {
        List<City> cityList = await _cityRepository.getAllCity();
        emit(CityLoadedState(cityList));
      }
      catch (e) {
        emit(CityErrorState(e.toString()));
      }
    });
    on<AddCityEvent>((event, emit) async {
      City city = City(id: await _cityRepository.getCount(), name: event.name);
      city.safe();
      add(GetCityEvent());
    });
    on<DeleteCityEvent>((event, emit) async {
      event.city.delete();
      add(GetCityEvent());
    });
  }
}
