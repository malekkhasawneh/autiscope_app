import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/splash/domain/repository/splash_repository.dart';
import 'package:dartz/dartz.dart';

class IsLoginUseCase extends UseCase<bool, NoParams> {
  final SplashRepository repository;

  IsLoginUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.isLogin();
  }
}
