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
  const AddChildLoaded();

  @override
  List<Object> get props => [];
}

class GetChildLoaded extends AddChildState {
  final ChildModel childModel;

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
