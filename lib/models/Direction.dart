
import 'package:front/models/Subject.dart';

import 'ReceivedStudent.dart';
import 'Require.dart';

class Direction {
  int id;
  String name;
  int studentCount;
  List<Require> requireList;
  List<ReceivedStudent> receivedStudents;

  Direction({
    required this.id,
    required this.name,
    required this.studentCount,
    required this.requireList,
    required this.receivedStudents
  });

  factory Direction.fromJson(Map<String, dynamic> json) {
    List<Require> resultList = [];
    if (json['require'] != []) {
      for (dynamic item in json['require']) {
        resultList.add(Require(subject: Subject(id: item['subject_id'], name: item['name']), minPoint: item['min_point']));
      }
    }
    List<ReceivedStudent> receivedStudents = [];
    if (json['students'] != []) {
      for (dynamic item in json['students']) {
        receivedStudents.add(ReceivedStudent(id: item['id'], fio: item['fio']));
      }
    }
    return Direction(
      id: json['direction_id'] as int,
      name: json['name'] as String,
      studentCount: json['student_count'] as int,
      requireList: resultList,
      receivedStudents: receivedStudents,
    );
  }
}