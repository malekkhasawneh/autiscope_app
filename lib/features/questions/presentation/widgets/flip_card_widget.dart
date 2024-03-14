import 'dart:io';

import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlipCardWidget extends StatelessWidget {
  const FlipCardWidget({
    super.key,
    required this.controller,
    required this.image,
    required this.onTap,
    required this.flip,
  });

  final FlipCardController controller;
  final String image;
  final void Function()? onTap;
  final bool flip;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
        builder: (context, state) {
      return FlipCard(
        rotateSide: RotateSide.right,
        disableSplashEffect: false,
        splashColor: Colors.orange,
        onTapFlipping: flip,
        axis: FlipAxis.vertical,
        controller: controller,
        frontWidget: GestureDetector(
          onTap: () {},
          child: Container(
            width: 115,
            height: 115,
            decoration: BoxDecoration(
              color: Colors.white,
              image:
                  DecorationImage(image: FileImage(File(image)), fit: BoxFit.fill),
            ),
          ),
        ),
        backWidget: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 115,
            height: 115,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
