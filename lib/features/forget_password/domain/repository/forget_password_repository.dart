import 'package:autiscope_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failures, bool>> resetPassword({required String email});
}
