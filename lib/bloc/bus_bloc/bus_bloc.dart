import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bus_event.dart';
part 'bus_state.dart';

class BusBloc extends Bloc<BusEvent, BusState> {
  BusBloc() : super(BusInitial()) {
    on<BusEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
