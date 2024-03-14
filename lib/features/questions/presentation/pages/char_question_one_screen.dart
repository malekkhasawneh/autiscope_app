import 'dart:io';

import 'package:autiscope_app/core/resources/contants.dart';
import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class CharacterQuestionOneScreen extends StatefulWidget {
  const CharacterQuestionOneScreen({super.key});

  @override
  State<CharacterQuestionOneScreen> createState() =>
      _CharacterQuestionOneScreenState();
}

class _CharacterQuestionOneScreenState
    extends State<CharacterQuestionOneScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    QuestionsCubit.get(context).initSpeechToText();
    _controller = VideoPlayerController.file(File(Images.fileImagesPath + Constants.firstQuestionVideo))
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(_videoListener);
    Future.delayed(const Duration(seconds: 1)).then((_) {
      _controller.play();
      _controller.setLooping(false);
    });
    super.initState();
  }

  Future<void> _videoListener() async {
    if (_controller.value.position >= _controller.value.duration) {
      Navigator.pushReplacementNamed(
          context, Routes.charQuestionTwoScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsCubit, QuestionsState>(
      listener: (context, state) {
        if (state is ModelAnswerLoaded) {
          if (state.answer.isNotEmpty) {
            QuestionsCubit.get(context).startSpeechListen();
            Navigator.pushReplacementNamed(
                context, Routes.charQuestionTwoScreen);
          }
        }
      },
      child: Scaffold(
        body: _controller.value.isInitialized
            ? Center(
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
