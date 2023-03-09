import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:front/models/Subject.dart';
import 'package:meta/meta.dart';

import '../../models/Result.dart';
import '../../models/Student.dart';
import '../../repository/StudentRepository.dart';
import '../../repository/SubjectRepository.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository _studentRepository;
  StudentBloc(this._studentRepository) : super(StudentInitial()) {
    on<StudentGetEvent>((event, emit) async {
      emit(StudentLoadingState());
      try {
        final SubjectRepository _subjectRepository = SubjectRepository();
        List<Subject> subjectList = await _subjectRepository.getSubjects();
        List<Student> studentList = await _studentRepository.getStudents();
        emit(StudentLoadedState(studentList, subjectList));

      } catch(e) {
        emit(StudentErrorState(e.toString()));
      }
    });

    on<StudentAddEvent>((event, emit) async {
      await _studentRepository.addStudent(event.fio, event.age);
      add(StudentGetEvent());
    });

    on<StudentAddSubjectEvent>((event, emit) async {
      await _studentRepository.addStudentSubject(event.point, event.studentId, event.subjectId);
      add(StudentGetEvent());
    });



  }
}
