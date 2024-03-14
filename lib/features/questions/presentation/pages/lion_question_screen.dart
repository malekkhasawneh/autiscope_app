import 'dart:developer';

import 'package:autiscope_app/core/helpers/audio_player_helper.dart';
import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LionQuestionScreen extends StatefulWidget {
  const LionQuestionScreen({super.key});

  @override
  State<LionQuestionScreen> createState() => _LionQuestionScreenState();
}

class _LionQuestionScreenState extends State<LionQuestionScreen> {
  @override
  void initState() {
    QuestionsCubit.get(context)
        .initModel(model: ModelsConstants.questionFourModel);
    AudioPlayerHelper.playAudio(path: Audios.animalName);
    addListener();
    super.initState();
  }

  void addListener() {
    AudioPlayerHelper.player.positionStream.listen((position) {
      if (position == AudioPlayerHelper.player.duration!) {
        log('======================================== True');
        QuestionsCubit.get(context).recorder();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsCubit, QuestionsState>(
      listener: (context, state) {
        if (state is ModelAnswerLoaded) {
          if (state.answer.isNotEmpty) {
            Navigator.pushReplacementNamed(
                context, Routes.flipQuestionScreen);
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            Images.lionImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
