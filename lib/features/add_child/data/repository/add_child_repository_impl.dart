import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/network/network_info.dart';
import 'package:autiscope_app/features/add_child/data/datasource/add_child_remote_datasource.dart';
import 'package:autiscope_app/features/add_child/data/model/child_model.dart';
import 'package:autiscope_app/features/add_child/domain/repository/add_child_repository.dart';
import 'package:dartz/dartz.dart';

class AddChildRepositoryImpl implements AddChildRepository {
  final AddChildRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AddChildRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, bool>> addChild(
      {required String userId,
      required String name,
      required String nickName,
      required String age}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.addChild(
            userId: userId, name: name, nickName: nickName, age: age);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: 'server error'));
      }
    } else {
      return const Left(InternetFailure(failure: 'no internet'));
    }
  }

  @override
  Future<Either<Failures, List<ChildModel>>> getChildren(
      {required String userId}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.getChildren(
          userId: userId,
        );
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: 'server error'));
      }
    } else {
      return const Left(InternetFailure(failure: 'no internet'));
    }
  }

  @override
  Future<Either<Failures, void>> downloadVideo(
      {required String fileName}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.downloadVideo(fileName: fileName);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: 'server error'));
      }
    } else {
      return const Left(InternetFailure(failure: 'no internet'));
    }
  }
}
