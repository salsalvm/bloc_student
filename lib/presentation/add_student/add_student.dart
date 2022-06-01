import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors.dart';
import 'package:student/core/constant.dart';
import 'package:student/domain/cubit/student_cubit.dart';
import 'package:student/domain/student_model/student_model.dart';
import 'package:student/presentation/add_student/widget/image_pick.dart';

String noImage =
    'https://t3.ftcdn.net/jpg/04/34/72/82/240_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg';

class AddStudentDetails extends StatelessWidget {
  AddStudentDetails({Key? key}) : super(key: key);
  final nameControler = TextEditingController();
  final ageControler = TextEditingController();
  final branchControler = TextEditingController();
  final markControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Student Details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: kWhiteColor)),
              child: Column(
                children: [
                  kHeight10,
                  ImagePick(),

                  kHeight10,
                  CupertinoTextFormFieldRow(
                    controller: nameControler,
                    placeholder: 'Name...',
                    decoration: BoxDecoration(
                        color: kWhiteColor, borderRadius: kradius30),
                  ),
                  CupertinoTextFormFieldRow(
                    controller: ageControler,
                    keyboardType: TextInputType.number,
                    placeholder: 'Age...',
                    decoration: BoxDecoration(
                        color: kWhiteColor, borderRadius: kradius30),
                  ),
                  CupertinoTextFormFieldRow(
                    controller: branchControler,
                    placeholder: 'Branch...',
                    decoration: BoxDecoration(
                        color: kWhiteColor, borderRadius: kradius30),
                  ),
                  CupertinoTextFormFieldRow(
                    controller: markControler,
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

                        return addButtonPressed(state, context);
                      },
                    ),
                  ),
                  kHeight10
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BlocListener<StudentCubit, StudentState> addButtonPressed(
      InitialState state, BuildContext context) {
    return BlocListener<StudentCubit, StudentState>(
      listener: (context, state) {
        state as InitialState;
        if (state.added == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
              margin: EdgeInsets.all(10),
              content: Text('success fully added')));
        }
      },
      child: TextButton(
        onPressed: () {
          final name = nameControler.text.trim();
          final age = ageControler.text.trim();
          final branch = branchControler.text.trim();
          final mark = markControler.text.trim();
          final image = state.image;

          if (name.isEmpty ||
              age.isEmpty ||
              branch.isEmpty ||
              mark.isEmpty ||
              image == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                margin: EdgeInsets.all(10),
                content: Text('Every Fields Are Required')));
            return;
          } else {
            final studentDetails = StudentModel(
                age: age,
                branch: branch,
                mark: mark,
                name: name,
                image: state.image ?? noImage);
            context.read<StudentCubit>().addStudent(studentDetails);
            Navigator.pop(context);
          }
        },
        child: const Text(
          'add',
          style: TextStyle(color: kBlackColor),
        ),
      ),
    );
  }
}
