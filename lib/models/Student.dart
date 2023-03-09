

import 'package:front/models/Subject.dart';

import 'Result.dart';

class Student {
  int id;
  String fio;
  int age;
  List<Result> resultList;

  Student({
    required this.id,
    required this.fio,
    required this.age,
    required this.resultList
  });
  factory Student.fromJson(Map<String, dynamic> json) {
    List<Result> resultList = [];
    if (json['result'] != []) {
      for (dynamic item in json['result']) {
        resultList.add(Result(subject: Subject(id: item['subject_id'], name: item['subject_name']), result: item['point']));
      }
    }
    return Student(
      id: json['student_id'] as int,
      fio: json['fio'] as String,
      age: json['age'] as int,
      resultList: resultList,
    );
  }
}