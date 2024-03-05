import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/forget_password/domain/repository/forget_password_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ResetPasswordUseCase extends UseCase<bool, ResetPasswordUseCaseParams> {
  final ForgetPasswordRepository repository;

  ResetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(ResetPasswordUseCaseParams params) async {
    return await repository.resetPassword(email: params.email);
  }
}

class ResetPasswordUseCaseParams extends Equatable {
  final String email;

  const ResetPasswordUseCaseParams({required this.email});

  @override
  List<Object?> get props => [email];
}
