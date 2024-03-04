import 'dart:io';

import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/core/usecase/usecase.dart';
import 'package:autiscope_app/features/watch_video/data/model/autism_model.dart';
import 'package:autiscope_app/features/watch_video/domain/repository/watch_video_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CheckForAutismUseCase
    extends UseCase<AutismModel, CheckForAutismUseCaseParams> {
  final WatchVideoRepository repository;

  CheckForAutismUseCase({required this.repository});

  @override
  Future<Either<Failures, AutismModel>> call(
      CheckForAutismUseCaseParams params) async {
    return await repository.checkForAutism(params.images);
  }
}

class CheckForAutismUseCaseParams extends Equatable {
  final List<File> images;

  const CheckForAutismUseCaseParams({required this.images});

  @override
  List<Object?> get props => [images];
}
