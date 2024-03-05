part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();
}

class ForgetPasswordInitial extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordLoading extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class ForgetPasswordLoaded extends ForgetPasswordState {
  final bool success;

  const ForgetPasswordLoaded({required this.success});

  @override
  List<Object> get props => [success];
}

class ForgetPasswordError extends ForgetPasswordState {
  final String failure;

  const ForgetPasswordError({required this.failure});

  @override
  List<Object> get props => [failure];
}

//Set And Get States
class SetAndGetLoading extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}

class SetAndGetLoaded extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}
