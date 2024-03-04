import 'package:autiscope_app/core/errors/failures.dart';
import 'package:autiscope_app/features/add_child/data/model/child_model.dart';
import 'package:dartz/dartz.dart';

abstract class AddChildRepository {
  Future<Either<Failures, bool>> addChild(
      {required String userId,
      required String name,
      required String nickName,
      required String age});

  Future<Either<Failures, List<ChildModel>>> getChildren(
      {required String userId});
}
