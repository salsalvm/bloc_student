import 'package:hive_flutter/hive_flutter.dart';
part 'student_model.g.dart';
@HiveType(typeId: 1)
class StudentModel {
  StudentModel({
    required this.age,
    required this.branch,
    required this.mark,
    required this.name,
    required this.image,
  });
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String branch;
  @HiveField(3)
  final String mark;
  @HiveField(4)
  final String image;
}
