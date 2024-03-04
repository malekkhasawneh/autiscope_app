import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/add_child/domain/repository/add_child_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddChildUseCase extends UseCase<void, AddChildUseCaseParams> {
  final AddChildRepository repository;

  AddChildUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(AddChildUseCaseParams params) async {
    return await repository.addChild(
        userId: params.userId,
        name: params.name,
        nickName: params.nickName,
        age: params.age);
  }
}

class AddChildUseCaseParams extends Equatable {
  final String userId;
  final String name;
  final String nickName;
  final String age;

  const AddChildUseCaseParams(
      {required this.userId,
      required this.name,
      required this.nickName,
      required this.age});

  @override
  List<Object?> get props => [userId, name, nickName, age];
}
