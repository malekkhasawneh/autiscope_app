import 'dart:io';

import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/features/watch_video/data/model/autism_model.dart';
import 'package:dartz/dartz.dart';

abstract class WatchVideoRepository{
  Future<Either<Failures,AutismModel>> checkForAutism(List<File> images);
}