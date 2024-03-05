import 'dart:developer';
import 'dart:io';

import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/features/watch_video/data/model/autism_model.dart';
import 'package:dio/dio.dart';

abstract class WatchVideoRemoteDataSource {
  Future<AutismModel> checkForAutism(List<File> images);
}

class WatchVideoRemoteDataSourceImpl implements WatchVideoRemoteDataSource {
  @override
  Future<AutismModel> checkForAutism(List<File> images) async {
    try {
      List<MultipartFile> multipartFiles = [];
      for (File imageFile in images) {
        String fileName = imageFile.path.split('/').last;
        multipartFiles.add(
          await MultipartFile.fromFile(imageFile.path, filename: fileName),
        );
      }
      FormData formData = FormData.fromMap({
        'images[]': multipartFiles,
      });
      Response response =
          await Dio().post('https://yhabbeh-flask.hf.space/uploads', data: formData);
      log('====================================== success ${response.data}');
      if (response.statusCode == 200) {
        AutismModel autismModel = AutismModel.fromJson(response.data);
        return autismModel;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }
}
