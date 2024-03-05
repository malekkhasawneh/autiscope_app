import 'package:autiscope_app/core/errors/exceptions.dart';
import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/network/network_info.dart';
import 'package:autiscope_app/features/forget_password/data/datasource/forget_password_remote_datasource.dart';
import 'package:autiscope_app/features/forget_password/domain/repository/forget_password_repository.dart';
import 'package:dartz/dartz.dart';

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordRemoteDataSource forgetPasswordRemoteDataSource;
  final NetworkInfo networkInfo;

  ForgetPasswordRepositoryImpl(
      {required this.forgetPasswordRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failures, bool>> resetPassword({required String email}) async {
    if (await networkInfo.checkConnection()) {
      try {
        final response =
            await forgetPasswordRemoteDataSource.resetPassword(email: email);
        return Right(response);
      } on ServerException {
        return const Left(ServerFailure(failure: 'server error'));
      }
    } else {
      return const Left(InternetFailure(failure: 'no internet'));
    }
  }
}
