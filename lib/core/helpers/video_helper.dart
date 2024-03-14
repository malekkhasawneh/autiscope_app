import 'dart:io';

import 'package:autiscope_app/core/resources/contants.dart';
import 'package:path_provider/path_provider.dart';

class VideoHelper {
  static Future<String> getLocalVideo(String fileName) async {
    Directory appDocDir = await getTemporaryDirectory();
    String filePath = '${appDocDir.path}/$fileName';
    File localFile = File(filePath);
    if (await localFile.exists()) {
      return filePath;
    } else {
      return '';
    }
  }
}
