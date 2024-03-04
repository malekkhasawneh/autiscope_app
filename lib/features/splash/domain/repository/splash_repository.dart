import 'package:autiscope_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class SplashRepository {
  Future<Either<Failures, void>> setIsFirstTime();

  Future<Either<Failures, bool>> getIsFirstTime();
}
