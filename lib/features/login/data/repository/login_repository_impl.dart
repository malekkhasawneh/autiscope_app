import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/network/network_info.dart';
import 'package:autiscope_app/features/login/data/datasource/login_local_datasource.dart';
import 'package:autiscope_app/features/login/data/datasource/login_remote_datasource.dart';
import 'package:autiscope_app/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failures, User>> login(
      {required String email, required String password}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await remoteDataSource.login(email: email, password: password);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: 'server error'));
      }
    } else {
      return const Left(InternetFailure(failure: 'no internet'));
    }
  }

  @override
  Future<Either<Failures, User>> getUserInfo() async {
    try {
      final response = await localDataSource.getUserInfo();
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: 'cache error'));
    }
  }

  @override
  Future<Either<Failures, void>> setUserInfo({required User user}) async {
    try {
      final response = await localDataSource.setUserInfo(user: user);
      return Right(response);
    } on CacheException {
      return const Left(CacheFailure(failure: 'cache error'));
    }
  }
}
