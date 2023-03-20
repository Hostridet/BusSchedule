import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:front/repository/BusRepository.dart';
import 'package:front/repository/BusTypeRepository.dart';
import 'package:meta/meta.dart';

import '../../models/Bus.dart';
import '../../models/BusType.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  final BusRepository _busRepository;
  BusBloc(this._busRepository) : super(BusInitial()) {
    on<BusEvent>((event, emit) async {
      emit(BusLoadingState());
      try {
        List<Bus> busList = await _busRepository.getAllBusType();
        BusTypeRepository _busTypeRepository = BusTypeRepository();
        List<BusType> busTypeList = await _busTypeRepository.getAllBusType();
        emit(BusLoadedState(busList, busTypeList));
      }
      catch (e) {
        emit(BusErrorState(e.toString()));
      }
    });
    on<AddBusEvent>((event, emit) async {
      Bus bus = Bus(id: await _busRepository.getCount(), number: event.number, busType: event.busType);
      bus.save();
      add(GetBusEvent());
    });
    on<DeleteBusEvent>((event, emit) async {
      event.bus.delete();
      add(GetBusEvent());
    });
  }
}
