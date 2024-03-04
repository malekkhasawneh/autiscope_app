import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/splash/domain/repository/splash_repository.dart';
import 'package:dartz/dartz.dart';

class SetIsFirstTimeUseCase extends UseCase<void, NoParams> {
  final SplashRepository repository;

  SetIsFirstTimeUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(NoParams params) async {
    return await repository.setIsFirstTime();
  }
}
