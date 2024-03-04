import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/splash/domain/repository/splash_repository.dart';
import 'package:dartz/dartz.dart';

class GetIsFirstTimeUseCase extends UseCase<bool, NoParams> {
  final SplashRepository repository;

  GetIsFirstTimeUseCase({required this.repository});

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await repository.getIsFirstTime();
  }
}
