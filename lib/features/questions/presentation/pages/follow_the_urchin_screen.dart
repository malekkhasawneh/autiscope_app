import 'dart:developer';
import 'dart:io';

import 'package:autiscope_app/core/helpers/audio_player_helper.dart';
import 'package:autiscope_app/core/resources/contants.dart';
import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class FollowTheUrchinScreen extends StatefulWidget {
  const FollowTheUrchinScreen({super.key});

  @override
  State<FollowTheUrchinScreen> createState() => _FollowTheUrchinScreenState();
}

class _FollowTheUrchinScreenState extends State<FollowTheUrchinScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    AudioPlayerHelper.playAudio(path: Audios.followTheUrchin);
    _controller = VideoPlayerController.file(
        File(Images.fileImagesPath + Constants.urchinVideo))
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(_videoListener);
    Future.delayed(const Duration(seconds: 3)).then((_) {
      log('======================================= Started');
      _controller.play();
      _controller.setLooping(false);
    });
    super.initState();
  }

  Future<void> _videoListener() async {
    if (_controller.value.position >= _controller.value.duration) {
      Navigator.pushReplacementNamed(context, Routes.matchingQuestionScreen);
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
