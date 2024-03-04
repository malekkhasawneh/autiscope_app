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
      Response response = await Dio().post('path', data: {'images': images});
      if (response.statusCode == 200) {
        AutismModel autismModel =
            AutismModel.fromJson(response.data as Map<String, dynamic>);
        return autismModel;
      } else {
        throw ServerException();
      }
    } on Exception {
      throw ServerException();
    }
  }
}
