import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final int id;
  final String question;
  bool isSelected = false;

  QuestionEntity(
      {required this.id, required this.question, this.isSelected = false});

  @override
  List<Object?> get props => [id, question, isSelected];
}
