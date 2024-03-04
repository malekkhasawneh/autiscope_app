import 'package:autiscope_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class SignUpRepository{
  Future<Either<Failures,bool>> signUp(
      {required String email,
        required String password,
        required String firstName,
        required String lastName});
}