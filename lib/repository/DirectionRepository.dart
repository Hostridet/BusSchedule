
import 'dart:convert';

import 'package:front/models/ReceivedStudent.dart';
import 'package:http/http.dart' as http;
import '../models/Direction.dart';

class DirectionRepository {
  Future<List<Direction>> getDirections() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/api/direction'));
    List<Direction> directionList = [];
    var data = json.decode(utf8.decode(response.bodyBytes));
    for (dynamic item in data) {
      directionList.add(Direction.fromJson(item));
    }
    return directionList;
  }
  Future<List<ReceivedStudent>> receivedStudent() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/api/students'));
    var data = json.decode(utf8.decode(response.bodyBytes));
    List<ReceivedStudent> receivedList = [];
    for (dynamic item in data) {
      receivedList.add(ReceivedStudent.fromJson(item));
    }
    return receivedList;
  }

  Future<void> addStudent(int studentId, int directionId) async {
    final response = await http.post(Uri.parse('http://127.0.0.1:5000/api/direction/student'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: createBody(studentId, directionId),
    );
  }

  String createBody(int studentid, int directionId) {
    return jsonEncode({
      'student_id': studentid,
      'direction_id': directionId,
    });
  }
}