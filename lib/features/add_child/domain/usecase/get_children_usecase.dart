import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/add_child/data/model/child_model.dart';
import 'package:autiscope_app/features/add_child/domain/repository/add_child_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetChildrenUseCase extends UseCase<List<ChildModel>, GetChildrenUseCaseParams> {
  final AddChildRepository repository;

  GetChildrenUseCase({required this.repository});

  @override
  Future<Either<Failures, List<ChildModel>>> call(GetChildrenUseCaseParams params) async {
    return await repository.getChildren(
      userId: params.userId,
    );
  }
}

class GetChildrenUseCaseParams extends Equatable {
  final String userId;

  const GetChildrenUseCaseParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}
