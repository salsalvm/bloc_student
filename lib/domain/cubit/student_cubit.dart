import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/domain/student_model/student_model.dart';
import 'package:student/main.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit()
      : super(
          InitialState(
            studentDetails:
                Hive.box<StudentModel>('student_db').values.toList(),
          ),
        );
  void addStudent(StudentModel studentDetails) {
    box.add(studentDetails);
    return emit(InitialState(studentDetails: box.values.toList(), added: true));
  }

  void deleteStudent(int index) {
    final key = box.keys;
    final thisBox = key.elementAt(index);
    box.delete(thisBox);
    emit(InitialState(studentDetails: box.values.toList(), added: true));
  }

  void updateStudent(
    StudentModel updatedDetails,
    int index,
  ) {
    box.putAt(index, updatedDetails);
    emit(InitialState(studentDetails: box.values.toList(), added: true));
  }

  void searchStudent(String query) {
    final searched = box.values
        .toList()
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(InitialState(studentDetails: searched));
  }

  void pickedImage(XFile? image) {
    if (image != null) {
      return emit(
          InitialState(studentDetails: box.values.toList(), image: image.path));
    } else {
      return;
    }
  }
}
