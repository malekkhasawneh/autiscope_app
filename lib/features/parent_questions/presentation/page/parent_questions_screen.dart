import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/parent_questions/presentation/cubit/parent_question_cubit.dart';
import 'package:autiscope_app/features/parent_questions/presentation/widgets/question_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParentQuestionsScreen extends StatelessWidget {
  const ParentQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParentQuestionCubit, ParentQuestionState>(
        builder: (context, state) {
      return Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 60,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.parentQuestionScreenTitle,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  ...ParentQuestionCubit.get(context).questions.map(
                        (question) => QuestionCustomWidget(
                          question: question,
                        ),
                      ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 90,
                    height: 30,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // Border radius here
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.watchVideoScreen);
                        },
                        child: const Text(Strings.next)),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
