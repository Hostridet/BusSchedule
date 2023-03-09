
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/Subject.dart';

class SubjectRepository {
  Future<List<Subject>> getSubjects() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/api/subject'));
    List<Subject> listSubject = [];
    var data = json.decode(utf8.decode(response.bodyBytes));
    for (dynamic item in data) {
      listSubject.add(Subject.fromJson(item));
    }
    return listSubject;
  }

  Future<void> addSubject(String name) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:5000/api/subject/add'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: createBody(name),
    );
  }

  Future<void> deleteSubject(int id) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:5000/api/subject/delete'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: createDeleteBody(id),
    );
  }

  String createBody(String name) {
    return jsonEncode({
      "name": name,
    });
  }

  String createDeleteBody(int id) {
    return jsonEncode({
      "id": id,
    });
  }
}