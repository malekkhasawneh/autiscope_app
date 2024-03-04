import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/login/data/model/user_info_model.dart';
import 'package:autiscope_app/features/login/domain/repository/login_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserInfoUseCase extends UseCase<String, NoParams> {
  final LoginRepository repository;

  GetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failures, String>> call(NoParams params) async {
    return await repository.getUserInfo();
  }
}
