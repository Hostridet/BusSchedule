
class ReceivedStudent {
  int id;
  String fio;

  ReceivedStudent({
    required this.id,
    required this.fio,
});

  factory ReceivedStudent.fromJson(Map<String, dynamic> json) => ReceivedStudent(
    id: json['id'] as int,
    fio: json['fio'] as String,
  );
}