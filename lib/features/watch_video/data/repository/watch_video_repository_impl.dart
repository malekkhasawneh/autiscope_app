import 'dart:io';

import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/network/network_info.dart';
import 'package:autiscope_app/features/watch_video/data/datasource/watch_video_remote_datasource.dart';
import 'package:autiscope_app/features/watch_video/data/model/autism_model.dart';
import 'package:autiscope_app/features/watch_video/domain/repository/watch_video_repository.dart';
import 'package:dartz/dartz.dart';

class WatchVideoRepositoryImpl implements WatchVideoRepository {
  final WatchVideoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WatchVideoRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, AutismModel>> checkForAutism(
      List<File> images) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.checkForAutism(images);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: 'server error'));
      }
    } else {
      return const Left(InternetFailure(failure: 'no internet'));
    }
  }
}
