import 'dart:io';

import 'package:autiscope_app/core/resources/contants.dart';
import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class CharacterQuestionThreeScreen extends StatefulWidget {
  const CharacterQuestionThreeScreen({super.key});

  @override
  State<CharacterQuestionThreeScreen> createState() =>
      _CharacterQuestionThreeScreenState();
}

class _CharacterQuestionThreeScreenState
    extends State<CharacterQuestionThreeScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    QuestionsCubit.get(context)
        .initModel(model: ModelsConstants.questionTwoModel);
    _controller = VideoPlayerController.file(File(Images.fileImagesPath + Constants.thirdQuestionVideo))
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

  bool _isCompleted = false;

  Future<void> _videoListener() async {
    if (_controller.value.position >= _controller.value.duration) {
      if (!_isCompleted) {
        QuestionsCubit.get(context).recorder();
      }
      _isCompleted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsCubit, QuestionsState>(
      listener: (context, state) {
        if (state is ModelAnswerLoaded) {
          if (state.answer.isNotEmpty) {
            Navigator.pushReplacementNamed(context, Routes.charQuestionFourScreen);
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
