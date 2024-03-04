import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/network/network_info.dart';
import 'package:autiscope_app/features/signup/data/datasource/sign_up_local_datasource.dart';
import 'package:autiscope_app/features/signup/domain/repository/sign_up_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SignUpRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failures, bool>> signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response = await remoteDataSource.signUp(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: 'server error'));
      }
    } else {
      return const Left(InternetFailure(failure: 'no internet'));
    }
  }
}
