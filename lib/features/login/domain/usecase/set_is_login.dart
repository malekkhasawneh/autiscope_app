import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class SetIsLoginUseCase extends UseCase<void, NoParams> {
  final LoginRepository repository;

  SetIsLoginUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.setIsLogin();
  }
}
