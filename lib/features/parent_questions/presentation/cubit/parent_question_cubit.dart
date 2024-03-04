import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/parent_questions/domain/entity/question_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'parent_question_state.dart';

class ParentQuestionCubit extends Cubit<ParentQuestionState> {
  static ParentQuestionCubit get(BuildContext context) =>
      BlocProvider.of(context);

  ParentQuestionCubit() : super(ParentQuestionInitial());

  List<QuestionEntity> questions = [
    QuestionEntity(id: 1, question: Strings.question1, isSelected: false),
    QuestionEntity(id: 2, question: Strings.question2, isSelected: false),
    QuestionEntity(id: 3, question: Strings.question3, isSelected: false),
    QuestionEntity(id: 4, question: Strings.question4, isSelected: false),
    QuestionEntity(id: 5, question: Strings.question5, isSelected: false),
    QuestionEntity(id: 6, question: Strings.question6, isSelected: false),
    QuestionEntity(id: 7, question: Strings.question7, isSelected: false),
    QuestionEntity(id: 8, question: Strings.question8, isSelected: false),
    QuestionEntity(id: 9, question: Strings.question9, isSelected: false),
    QuestionEntity(id: 10, question: Strings.question10, isSelected: false),
  ];

  void setSelectedQuestion(int id) {
    emit(ParentQuestionLoading());
    questions.where((element) => element.id == id).first.isSelected =
        !questions.where((element) => element.id == id).first.isSelected;
    emit(ParentQuestionLoaded());
  }
}
