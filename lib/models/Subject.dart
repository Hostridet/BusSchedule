

class Subject {
  int id;
  String name;

  Subject({
    required this.id,
    required this.name
  });
  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json['id'] as int,
    name: json['name'] as String,
  );
}