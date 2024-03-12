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
    _controller = VideoPlayerController.asset('video/urchin_video.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    Future.delayed(const Duration(seconds: 1)).then((_) {
      _controller.play();
      _controller.setLooping(false);
      _controller.setVolume(0.0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
