part of 'add_child_cubit.dart';

abstract class AddChildState extends Equatable {
  const AddChildState();
}

class AddChildInitial extends AddChildState {
  @override
  List<Object> get props => [];
}

class AddChildLoading extends AddChildState {
  @override
  List<Object> get props => [];
}

class AddChildLoaded extends AddChildState {
  final bool success;

  const AddChildLoaded({required this.success});

  @override
  List<Object> get props => [success];
}

class GetChildLoaded extends AddChildState {
  final List<ChildModel> childModel;

  const GetChildLoaded({required this.childModel});

  @override
  List<Object> get props => [childModel];
}

class AddChildError extends AddChildState {
  final String failure;

  const AddChildError({required this.failure});

  @override
  List<Object> get props => [failure];
}

//Set And Get States
class SetAndGetLoading extends AddChildState {
  @override
  List<Object> get props => [];
}

class SetAndGetLoaded extends AddChildState {
  @override
  List<Object> get props => [];
}
class SaveVideoLoaded extends AddChildState {
  @override
  List<Object> get props => [];
}
