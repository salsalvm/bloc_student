
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student/core/colors.dart';
import 'package:student/domain/cubit/student_cubit.dart';

class ImagePick extends StatelessWidget {
  ImagePicker picker = ImagePicker();
  ImagePick({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentCubit, StudentState>(
      builder: (context, state) {
        state as InitialState;
        return Stack(
          alignment: Alignment.bottomRight,
          children: [ state.image==null? const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ):  
            CircleAvatar(
              radius: 60, 
              backgroundImage: FileImage(File(state.image.toString())),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: kBlackColor,
                        height: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  const Text(
                                    'Camera',
                                    style: TextStyle(color: kWhiteColor),
                                  ),
                                  BlocBuilder<StudentCubit, StudentState>(
                                    builder: (context, state) {
                                      return IconButton(
                                        onPressed: () async {
                                          XFile? image = await picker.pickImage(
                                              source: ImageSource.camera);
                                          context
                                              .read<StudentCubit>()
                                              .pickedImage(image);
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          CupertinoIcons.camera,
                                          color: kWhiteColor,
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Gallery',
                                  style: TextStyle(color: kWhiteColor),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    context
                                        .read<StudentCubit>()
                                        .pickedImage(image);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    color: kWhiteColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
              icon: const Icon(
                CupertinoIcons.camera,
                color: kWhiteColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
