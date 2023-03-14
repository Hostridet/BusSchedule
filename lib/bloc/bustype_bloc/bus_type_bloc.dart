import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:front/bloc/bustype_bloc/bus_type_bloc.dart';
import 'package:front/data/entity/BusType.dart';
import 'package:front/repository/BusTypeRepository.dart';
import 'package:meta/meta.dart';

part 'bus_type_event.dart';
part 'bus_type_state.dart';

class BusTypeBloc extends Bloc<BusTypeEvent, BusTypeState> {
  final BusTypeRepository _busTypeRepository;
  BusTypeBloc(this._busTypeRepository) : super(BusTypeInitial()) {
    on<BusTypeGetEvent>((event, emit) async {
      try {
        List<BusType> listBusType = await _busTypeRepository.getAllBusType();
        emit(BusTypeLoadedState(listBusType));
      }
      catch(e) {
        emit(BusTypeErrorState(e.toString()));
      }
    });
  }
}
