import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/constant.dart';
import 'package:student/domain/cubit/student_cubit.dart';
import 'package:student/presentation/update_student/update_student.dart';

class StudentDetail extends StatelessWidget {
  final int index;
  const StudentDetail({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>  UpdateStudent(index:index)),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.red,
              )),
          kWidth30
        ],
        title: const Text('Student Details'),
      ),
      body: SafeArea(
        child: BlocBuilder<StudentCubit, StudentState>(
          builder: (context, state) {
            state as InitialState;
            return ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(
                              state.studentDetails[index].image.toString())))),
                  height: size.width,
                  width: size.width,
                ),
                kHeight50,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Column(
                    children: [
                      ItemFields(
                          field: 'Name      :',
                          data: state.studentDetails[index].name.toUpperCase()),
                      ItemFields(
                          field: 'Branch    :',
                          data: state.studentDetails[index].branch),
                      ItemFields(
                          field: 'Age           :',
                          data: state.studentDetails[index].age),
                      ItemFields(
                          field: 'Mark       :',
                          data: state.studentDetails[index].mark),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ItemFields extends StatelessWidget {
  final String field;
  final String data;
  const ItemFields({Key? key, required this.field, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(field),const Spacer(), Text(data,style:const TextStyle(fontSize: 20,),), kHeight50],
    );
  }
}
