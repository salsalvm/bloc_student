import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors.dart';
import 'package:student/domain/cubit/student_cubit.dart';
import 'package:student/domain/student_model/student_model.dart';

class DeleteStudent extends StatelessWidget {
  final int index;
  const DeleteStudent({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text(
                    'Are You Confirm',
                    style: TextStyle(fontSize: 25),
                  ),
                  titleTextStyle: const TextStyle(color: kWhiteColor),
                  backgroundColor: const Color.fromARGB(255, 58, 57, 57),
                  content: const Text(
                    'you want to remove',
                  ),
                  contentTextStyle: const TextStyle(color: Colors.yellow),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: kWhiteColor),
                      ),
                    ),
                    deleteButtonPressed()
                  ],
                );
              });
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ));
  }

  BlocBuilder<StudentCubit, StudentState> deleteButtonPressed() {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        return BlocListener<StudentCubit, StudentState>(
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                margin: EdgeInsets.all(10),
                content: Text('Student profail deleted')));
          },
          child: TextButton(
            onPressed: () {
              context.read<StudentCubit>().deleteStudent(index);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
