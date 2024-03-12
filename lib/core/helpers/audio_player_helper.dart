import 'dart:developer';

import 'package:just_audio/just_audio.dart';

class AudioPlayerHelper {
  static final player = AudioPlayer();

  static Future<void> playAudio({required String path}) async {
    await player.setAsset(path);
    await player.play();
  }

  static Future<void> pauseAudio() async {
    await player.pause();
  }

  static Future<void> resumeAudio() async {
    await player.play();
  }

  static Future<void> stopAudio() async {
    await player.stop();
  }

  static Future<void> getPosition() async {
    player.positionStream.listen((position) {
      log('============================== voice position ${position.inSeconds}');
    });
  }

}
