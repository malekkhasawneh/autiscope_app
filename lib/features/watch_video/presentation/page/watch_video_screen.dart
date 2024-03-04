import 'dart:developer';

import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/watch_video/presentation/cubit/watch_video_cubit.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
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
        autoPlay: true)..addListener(() {log('================================== jj ${_chewieController.videoPlayerController.value.isPlaying}');});
  }

  void _videoListener() {
    if (_videoController.value.position >= _videoController.value.duration) {
      WatchVideoCubit.get(context).stopCameraStreaming();
      WatchVideoCubit.get(context).checkForAutism();
      log('======================================== Ended');
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    WatchVideoCubit.get(context).stopCameraStreaming();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _videoController.seekTo(Duration.zero);
    _chewieController.seekTo(Duration.zero);
    _videoController.pause();
    _chewieController.pause();
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () {
                WatchVideoCubit.get(context).startCameraStream();
              },
              child: const Icon(Icons.start),
            ),
          ],
        ),
      ),
    );
  }
}
