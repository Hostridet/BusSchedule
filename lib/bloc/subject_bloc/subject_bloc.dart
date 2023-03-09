import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Subject.dart';
import '../../repository/SubjectRepository.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository _subjectRepository;
  SubjectBloc(this._subjectRepository) : super(SubjectInitial()){
    on<SubjectGetEvent>((event, emit) async {
      emit(SubjectLoadingState());
      try {
        List<Subject> listSubject = await _subjectRepository.getSubjects();
        emit(SubjectLoadedState(listSubject));
      } catch(e) {
        emit(SubjectErrorState("Не удалось загрузить предметы"));
      }
    });

    on<SubjectAddEvent>((event, emit) async {
      await _subjectRepository.addSubject(event.name);
      add(SubjectGetEvent());
    });

    on<SubjectDeleteEvent>((event, emit) async {
      await _subjectRepository.deleteSubject(event.id);
      add(SubjectGetEvent());
    });
  }
}
