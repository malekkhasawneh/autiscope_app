import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/parent_questions/domain/entity/question_entity.dart';
import 'package:autiscope_app/features/parent_questions/presentation/cubit/parent_question_cubit.dart';
import 'package:flutter/material.dart';

class QuestionCustomWidget extends StatelessWidget {
  const QuestionCustomWidget({
    super.key,
    required this.question,
  });

  final QuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Transform.translate(
          offset: const Offset(9, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                visualDensity: VisualDensity.compact,
                value: question.isSelected,
                onChanged: (bool? value) {
                  ParentQuestionCubit.get(context)
                      .setSelectedQuestion(question.id);
                },
                activeColor: AppColors.darkYellow,
                side: const BorderSide(
                  color: AppColors.darkYellow,
                  width: 1.5, // Border width
                ),
              ),
              Text(
                question.question,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
