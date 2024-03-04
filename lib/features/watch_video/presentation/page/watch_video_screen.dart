import 'package:autiscope_app/core/resources/resources.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({Key? key}) : super(key: key);

  @override
  _WatchVideoScreenState createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('video/video.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 9.5 / 7.5,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60,),
          const Text(
            Strings.watchVideoScreenTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 120,),
          SizedBox(
            height: 285,
            child: Chewie(
              controller: _chewieController,
            ),
          ),
        ],
      ),
    );
  }
}
