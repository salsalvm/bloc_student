import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/constant.dart';
import 'package:student/domain/cubit/student_cubit.dart';
import 'package:student/presentation/add_student/add_student.dart';
import 'package:student/presentation/list_student/widget/delete_student.dart';
import 'package:student/presentation/profail_student/profail.dart';
import 'package:student/presentation/search_student/search_student.dart';

class StudentProfiles extends StatelessWidget {
  const StudentProfiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: MySearch());
          }, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => AddStudentDetails()),
                  ),
                );
              },
              icon: const Icon(Icons.add)),
          kWidth30
        ],
      ),
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          state as InitialState;
          return state.studentDetails.isEmpty
              ?const Center(
                  child: Text(
                  'No item found!!!',
                  style: TextStyle(color: Colors.green),
                ))
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => StudentDetail(index: index)))),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                            File(state.studentDetails[index].image.toString())),
                        radius: 40,
                      ),
                      title: Text(state.studentDetails[index].name.toUpperCase(),
                          style: textWhite),
                      subtitle: Text(
                        state.studentDetails[index].branch,
                        style: textWhite,
                      ),
                      trailing: DeleteStudent(index: index),
                    );
                  }),
                  itemCount: state.studentDetails.length,
                );
        },
      ),
    );
  }
}
