import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetUserInfoUseCase extends UseCase<void, SetUserInfoUseCaseParams> {
  final LoginRepository repository;

  SetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(SetUserInfoUseCaseParams params) async {
    return await repository.setUserInfo(user: params.user);
  }
}

class SetUserInfoUseCaseParams extends Equatable {
  final User user;

  const SetUserInfoUseCaseParams({required this.user});

  @override
  List<Object?> get props => [user];
}
