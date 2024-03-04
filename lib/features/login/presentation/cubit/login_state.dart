part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  final User userInfo;

  const LoginLoaded({required this.userInfo});

  @override
  List<Object> get props => [userInfo];
}

class LoginError extends LoginState {
  final String failure;

  const LoginError({required this.failure});

  @override
  List<Object> get props => [failure];
}

//Set And Get States
class SetAndGetLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class SetAndGetLoaded extends LoginState {
  @override
  List<Object> get props => [];
}
