part of 'student_cubit.dart';

class StudentState {}

class InitialState extends StudentState {
  String? image;
  bool? added;
  final List<StudentModel> studentDetails;
  InitialState({required this.studentDetails, this.image,this.added});
}
