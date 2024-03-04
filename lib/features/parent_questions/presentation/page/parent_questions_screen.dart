import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/parent_questions/presentation/widgets/question_custom_widget.dart';
import 'package:flutter/material.dart';

class ParentQuestionsScreen extends StatelessWidget {
  const ParentQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                const QuestionCustomWidget(question: Strings.question1,),
                const QuestionCustomWidget(question: Strings.question2,),
                const QuestionCustomWidget(question: Strings.question3,),
                const QuestionCustomWidget(question: Strings.question4,),
                const QuestionCustomWidget(question: Strings.question5,),
                const QuestionCustomWidget(question: Strings.question6,),
                const QuestionCustomWidget(question: Strings.question7,),
                const QuestionCustomWidget(question: Strings.question8,),
                const QuestionCustomWidget(question: Strings.question9,),
                const QuestionCustomWidget(question: Strings.question10,),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 90 ,
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
                      onPressed: () {},
                      child: const Text(Strings.next)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
