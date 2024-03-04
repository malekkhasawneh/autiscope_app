import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/features/splash/data/datasource/splash_local_datasource.dart';
import 'package:autiscope_app/features/splash/domain/repository/splash_repository.dart';
import 'package:dartz/dartz.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource localDataSource;

  SplashRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failures, bool>> getIsFirstTime() async {
    try {
      final response = await localDataSource.getIsFirstTime();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: 'CacheFailure'));
    }
  }

  @override
  Future<Either<Failures, void>> setIsFirstTime() async {
    try {
      final response = await localDataSource.setIsFirstTime();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: 'CacheFailure'));
    }
  }
}
