import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student/core/colors.dart';
import 'package:student/core/constant.dart';
import 'package:student/domain/cubit/student_cubit.dart';
import 'package:student/presentation/profail_student/profail.dart';

class MySearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          color: kGreyColor,
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(
            Icons.clear,
          ))
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      textTheme: const TextTheme(displayMedium: TextStyle(color: kBlackColor)),
      hintColor: kWhiteColor,
      appBarTheme: const AppBarTheme(
        color: kBlackColor,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            border: InputBorder.none,
          ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: kWhiteColor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        "$query  is not found!!!",
        style: const TextStyle(color: kWhiteColor),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(builder: (context, state) {
      state as InitialState;
      context.read<StudentCubit>().searchStudent(query);
      return Scaffold(
        backgroundColor: kBlackColor,
        body: state.studentDetails.isEmpty
            ? const Center(
                child: Text(
                "No Data Found!",
                style: TextStyle(color: Colors.green),
              ))
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) =>
                                    StudentDetail(index: index)))),
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                              File(state.studentDetails[index].image)),
                          radius: 40,
                        ),
                        title: Text(
                            state.studentDetails[index].name.toUpperCase(),
                            style: textWhite),
                        subtitle: Text(
                          state.studentDetails[index].branch,
                          style: textWhite,
                        ),
                      ));
                  // return ListTile(
                },
                separatorBuilder: (context, index) {
                  return  const SizedBox(
                    height: 10,
                  );
                },
                itemCount: state.studentDetails.length),
      );
    });
  }
}
