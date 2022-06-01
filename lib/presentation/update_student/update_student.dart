import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors.dart';
import 'package:student/core/constant.dart';
import 'package:student/domain/cubit/student_cubit.dart';
import 'package:student/domain/student_model/student_model.dart';
import 'package:student/presentation/update_student/widget/update_image.dart';

class UpdateStudent extends StatelessWidget {
  final int index;
  const UpdateStudent({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student Details'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: kWhiteColor)),
            child: BlocBuilder<StudentCubit, StudentState>(
              builder: (context, state) {
                state as InitialState;
                final updateName = TextEditingController(
                    text: state.studentDetails[index].name);
                final updateAge = TextEditingController(
                    text: state.studentDetails[index].age);
                final updateBranch = TextEditingController(
                    text: state.studentDetails[index].branch);
                final updateMark = TextEditingController(
                    text: state.studentDetails[index].mark);
                return Column(
                  children: [
                    kHeight10,

                    UpdateImage(index: index),

                    kHeight10,
                    CupertinoTextFormFieldRow(
                      controller: updateName,
                      placeholder: 'Name...',
                      decoration: BoxDecoration(
                          color: kWhiteColor, borderRadius: kradius30),
                    ),
                    CupertinoTextFormFieldRow(
                      controller: updateAge,
                      keyboardType: TextInputType.number,
                      placeholder: 'Age...',
                      decoration: BoxDecoration(
                          color: kWhiteColor, borderRadius: kradius30),
                    ),
                    CupertinoTextFormFieldRow(
                      controller: updateBranch,
                      placeholder: 'Batch...',
                      decoration: BoxDecoration(
                          color: kWhiteColor, borderRadius: kradius30),
                    ),
                    CupertinoTextFormFieldRow(
                      controller: updateMark,
                      keyboardType: TextInputType.number,
                      placeholder: 'mark...',
                      decoration: BoxDecoration(
                          color: kWhiteColor, borderRadius: kradius30),
                    ),
                    // kHeight50,
                    kHeight10,
                    Container(
                      decoration: BoxDecoration(
                          color: kWhiteColor, borderRadius: kradius30),
                      child: BlocBuilder<StudentCubit, StudentState>(
                        builder: (context, state) {
                          state as InitialState;
                          return BlocListener<StudentCubit, StudentState>(
                            listener: (context, state) {
                              state as InitialState;
                              if (state.added == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.green,
                                        margin: EdgeInsets.all(10),
                                        content:
                                            Text('success fully updated')));
                              }
                            },
                            child: TextButton(
                              onPressed: () {
                                final uName = updateName.text.trim();
                                final uAge = updateAge.text.trim();
                                final uMark = updateMark.text.trim();
                                final uBranch = updateBranch.text.trim();
                                if (uName.isEmpty ||
                                    uAge.isEmpty ||
                                    uMark.isEmpty ||
                                    uBranch.isEmpty) {
                                  return;
                                } else {
                                  final updatedDetails = StudentModel(
                                      age: uAge,
                                      branch: uBranch,
                                      mark: uMark,
                                      name: uName,
                                      image: state.image ??
                                          state.studentDetails[index].image);

                                  context
                                      .read<StudentCubit>()
                                      .updateStudent(updatedDetails, index);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(color: kBlackColor),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    kHeight10
                  ],
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
