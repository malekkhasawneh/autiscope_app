import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:flutter/material.dart';

class FindDifferenceScreen extends StatelessWidget {
  const FindDifferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bear_image_two.png'),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(-16, -55),
                    child: GestureDetector(
                      onTap: (){
                        QuestionsCubit.get(context).setBearAnswers = 1;
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(18, 83),
                    child: GestureDetector(
                      onTap: (){
                        QuestionsCubit.get(context).setBearAnswers = 2;
                      },
                      child: Container(
                        width: 55,
                        height: 62,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(49, 17),
                    child:GestureDetector(
                      onTap: (){
                        QuestionsCubit.get(context).setBearAnswers = 3;
                      },
                      child: Container(
                        width: 42,
                        height: 47,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bear_image_one.png'),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(-16, -55),
                    child: GestureDetector(
                      onTap: (){
                        QuestionsCubit.get(context).setBearAnswers = 1;
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(18, 83),
                    child: GestureDetector(
                      onTap: (){
                        QuestionsCubit.get(context).setBearAnswers = 2;
                      },
                      child: Container(
                        width: 55,
                        height: 62,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(49, 17),
                    child:GestureDetector(
                      onTap: (){
                        QuestionsCubit.get(context).setBearAnswers = 3;
                      },
                      child: Container(
                        width: 42,
                        height: 47,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
