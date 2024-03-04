part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoaded extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashError extends SplashState {
  final String error;

  const SplashError({required this.error});

  @override
  List<Object> get props => [error];
}

//Set And Get States
class SetAndGetLoading extends SplashState {
  @override
  List<Object> get props => [];
}
class SetAndGetLoaded extends SplashState {
  @override
  List<Object> get props => [];
}