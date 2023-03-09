part of 'student_bloc.dart';

@immutable
abstract class StudentEvent {}

class StudentGetEvent extends StudentEvent {}

class StudentAddEvent extends StudentEvent {
  final String fio;
  final int age;

  StudentAddEvent(this.fio, this.age);
}

class StudentAddSubjectEvent extends StudentEvent {
  final int subjectId;
  final int studentId;
  final int point;

  StudentAddSubjectEvent(this.studentId, this.subjectId, this.point);
}
