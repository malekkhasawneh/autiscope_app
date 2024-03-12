part of 'questions_cubit.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();
}

class CharQuestionsInitial extends QuestionsState {
  @override
  List<Object> get props => [];
}

class CharQuestionsLoading extends QuestionsState {
  @override
  List<Object> get props => [];
}

class CharQuestionsLoaded extends QuestionsState {
  @override
  List<Object> get props => [];
}

class CharQuestionsError extends QuestionsState {
  final String error;

  const CharQuestionsError({required this.error});

  @override
  List<Object> get props => [error];
}

class ModelAnswerLoaded extends QuestionsState {
  final String answer;

  const ModelAnswerLoaded({required this.answer});

  @override
  List<Object> get props => [answer];
}

//Set And Get Value States
class SetAndGetValueLoading extends QuestionsState {
  @override
  List<Object> get props => [];
}

class SetAndGetValueLoaded extends QuestionsState {
  @override
  List<Object> get props => [];
}
