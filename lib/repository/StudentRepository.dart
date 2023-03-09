
import 'dart:convert';

import 'package:front/repository/SubjectRepository.dart';
import 'package:http/http.dart' as http;
import '../models/Student.dart';

class StudentRepository {
  Future<List<Student>> getStudents() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/api/student'));
    var data = json.decode(utf8.decode(response.bodyBytes));
    List<Student> listStudent = [];
    for (dynamic item in data) {
      listStudent.add(Student.fromJson(item));
    }
    return listStudent;
  }

  Future<void> addStudent(String fio, int age) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:5000/api/student/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: createAddBody(fio, age),
    );
  }
  Future<void> addStudentSubject(int point, int studentId, int subjectId) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:5000/api/student/sub'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: createSubjectBody(point, studentId, subjectId),
    );
  }

  String createSubjectBody(int point, int studentId, int subjectId) {
    return jsonEncode({
      'point': point,
      'student_id': studentId,
      'subject_id': subjectId,
    });
  }


  String createAddBody(String fio, int age) {
    return jsonEncode({
      'fio': fio,
      'age': age,
    });
  }
}
