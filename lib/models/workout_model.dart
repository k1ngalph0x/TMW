class Workout {
  final int? id;
  final DateTime dateTime;
  final List<String> exercises;

  Workout({this.id, required this.dateTime, required this.exercises});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'exercises': exercises.join(','),
    };
  }

  static Workout fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] as int?,
      dateTime: DateTime.parse(map['dateTime'] as String),
      exercises: (map['exercises'] as String).split(','),
    );
  }
}
