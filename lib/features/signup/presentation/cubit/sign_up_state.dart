part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoaded extends SignUpState {
  final bool isSignUp;

  const SignUpLoaded({required this.isSignUp});

  @override
  List<Object> get props => [isSignUp];
}

class SignUpError extends SignUpState {
  final String error;

  const SignUpError({required this.error});

  @override
  List<Object> get props => [error];
}

//Set And Get States
class SetAndGetLoading extends SignUpState {
  @override
  List<Object> get props => [];
}

class SetAndGetLoaded extends SignUpState {
  @override
  List<Object> get props => [];
}
