import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:front/models/ReceivedStudent.dart';
import 'package:meta/meta.dart';

import '../../models/Direction.dart';
import '../../repository/DirectionRepository.dart';

part 'direction_event.dart';
part 'direction_state.dart';

class DirectionBloc extends Bloc<DirectionEvent, DirectionState> {
  final DirectionRepository _directionRepository;
  DirectionBloc(this._directionRepository) : super(DirectionInitial()) {
    on<DirectionGetEvent>((event, emit) async {
      try {
        List<Direction> directionList = await _directionRepository.getDirections();
        List<ReceivedStudent> receivedStudent = await _directionRepository.receivedStudent();
        emit(DirectionLoadedState(directionList, receivedStudent));
      } catch(e) {
        emit(DirectionErrorState(e.toString()));
      }
    });
    on<DirectionAddEvent>((event, emit) async {
      await _directionRepository.addStudent(event.studentId, event.directionId);
      add(DirectionGetEvent());
    });
  }
}
