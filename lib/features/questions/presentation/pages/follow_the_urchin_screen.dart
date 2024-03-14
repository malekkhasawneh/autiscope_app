import 'package:autiscope_app/core/helpers/audio_player_helper.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:flutter/material.dart';
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
    _controller = VideoPlayerController.asset(VideosNames.urchinVideo)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(_videoListener);
    Future.delayed(const Duration(seconds: 1)).then((_) {
      _controller.play();
      _controller.setLooping(false);
      _controller.setVolume(0.0);
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
    return Scaffold(
      body: _controller.value.isInitialized
          ? Center(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                child: VideoPlayer(_controller),
        ),
      )
          : const SizedBox(),
    );
  }
}
