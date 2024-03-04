import 'package:autiscope_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<Either<Failures, User>> login(
      {required String email, required String password});

  Future<Either<Failures, void>> setUserInfo({required User user});

  Future<Either<Failures, User>> getUserInfo();
}
