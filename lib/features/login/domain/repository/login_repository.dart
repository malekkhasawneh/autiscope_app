import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/features/login/data/model/user_info_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<Either<Failures, User>> login(
      {required String email, required String password});

  Future<Either<Failures, void>> setUserInfo({required User user});

  Future<Either<Failures, String>> getUserInfo();

  Future<Either<Failures, void>> setIsLogin();

}
