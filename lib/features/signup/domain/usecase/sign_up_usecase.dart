import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/signup/domain/repository/sign_up_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignUpUseCase extends UseCase<bool, SignUpUseCaseParams> {
  final SignUpRepository repository;

  SignUpUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(SignUpUseCaseParams params) async {
    return await repository.signUp(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName);
  }
}

class SignUpUseCaseParams extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const SignUpUseCaseParams(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}
