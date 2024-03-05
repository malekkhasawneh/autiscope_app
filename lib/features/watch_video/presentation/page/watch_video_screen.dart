import 'dart:developer';

import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:autiscope_app/features/parent_questions/presentation/cubit/parent_question_cubit.dart';
import 'package:autiscope_app/features/watch_video/presentation/cubit/watch_video_cubit.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({Key? key}) : super(key: key);

  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    WatchVideoCubit.get(context).initCamera();
    _videoController = VideoPlayerController.asset('video/video.mp4')
      ..addListener(_videoListener);
    _chewieController = ChewieController(
        videoPlayerController: _videoController,
        aspectRatio: 9.5 / 7.5,
        autoPlay: true)
      ..addListener(() {});
  }

  bool isComplete = false;

  Future<void> _videoListener() async {
    if (_videoController.value.position >= _videoController.value.duration) {
      if (!isComplete) {
        await Future.wait([
          WatchVideoCubit.get(context).checkForAutism(
              parentQuestions: ParentQuestionCubit.get(context).hasAutism),
          WatchVideoCubit.get(context).stopCameraStreaming()
        ]);
        log('======================================== Ended');
      }
      isComplete = true;
    }
  }

  @override
  void dispose() {
    WatchVideoCubit.get(context).stopCameraStreaming();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _videoController.seekTo(Duration.zero);
    _chewieController.seekTo(Duration.zero);
    _videoController.pause();
    _chewieController.pause();
    return BlocConsumer<WatchVideoCubit, WatchVideoState>(
        listener: (context, state) async {
      if (state is WatchVideoLoaded) {
        if (!state.isSuccess) {
          WatchVideoCubit.get(context).sendMail(text: Strings.positiveRepost,email: LoginCubit.get(context).userId);
        } else {
          WatchVideoCubit.get(context).sendMail(text: Strings.negativeRepost,email: LoginCubit.get(context).userId);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم ارسال النتيجه عبر البريد الالكتروني'),
          ),
        );
        Navigator.of(context).pushReplacementNamed(Routes.addChildScreen);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text(
                Strings.watchVideoScreenTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 120,
              ),
              SizedBox(
                height: 285,
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
