import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
  final String failure;

  const Failures({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class ServerFailure extends Failures {
  const ServerFailure({required super.failure});
}

class CacheFailure extends Failures {
  const CacheFailure({required super.failure});
}

class InternetFailure extends Failures {
  const InternetFailure({required super.failure});
}
