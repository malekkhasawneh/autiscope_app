import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/add_child/domain/repository/add_child_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class DownloadVideoUseCase extends UseCase<void, DownloadVideoUseCaseParams> {
  final AddChildRepository repository;

  DownloadVideoUseCase({required this.repository});

  @override
  Future<Either<Failures, void>> call(DownloadVideoUseCaseParams params) async {
    return await repository.downloadVideo(fileName: params.fileName);
  }
}

class DownloadVideoUseCaseParams extends Equatable {
  final String fileName;

  const DownloadVideoUseCaseParams({required this.fileName});

  @override
  List<Object?> get props => [fileName];
}
