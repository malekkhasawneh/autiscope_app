import 'package:autiscope_app/core/helpers/audio_player_helper.dart';
import 'package:autiscope_app/core/resources/contants.dart';
import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:autiscope_app/features/questions/presentation/widgets/flip_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlipQuestionScreen extends StatefulWidget {
  const FlipQuestionScreen({super.key});

  @override
  State<FlipQuestionScreen> createState() => _FlipQuestionScreenState();
}

class _FlipQuestionScreenState extends State<FlipQuestionScreen> {
  @override
  void initState() {
    AudioPlayerHelper.playAudio(path: Audios.chooseImages);
    QuestionsCubit.get(context).flipImagesTimer();
    super.initState();
  }

  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsCubit, QuestionsState>(
        listener: (context, state) async {
      if (QuestionsCubit.get(context).getSelectedCardsList.length == 4) {
        await Future.delayed(const Duration(seconds: 2)).then((_) {
          if (!_isAdded) {
            QuestionsCubit.get(context).addFlipResult();
          }
          _isAdded = true;
          Navigator.pushReplacementNamed(context, Routes.findDifferenceScreen);
        });
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlipCardWidget(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                            .getSelectedCardsList
                            .contains(1) &&
                        QuestionsCubit.get(context).canFlipImage) {
                      QuestionsCubit.get(context).setSelectedCardsList = 1;
                      QuestionsCubit.get(context).card1.flipcard();
                    }
                  },
                  controller: QuestionsCubit.get(context).card1,
                  image: Images.fileImagesPath + Constants.strawberryImage,
                  flip: !QuestionsCubit.get(context)
                          .getSelectedCardsList
                          .contains(4) &&
                      QuestionsCubit.get(context).canFlipImage,
                ),
                FlipCardWidget(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                            .getSelectedCardsList
                            .contains(2) &&
                        QuestionsCubit.get(context).canFlipImage) {
                      QuestionsCubit.get(context).setSelectedCardsList = 2;
                      QuestionsCubit.get(context).card2.flipcard();
                    }
                  },
                  controller: QuestionsCubit.get(context).card2,
                  image:Images.fileImagesPath + Constants.appleImage,
                  flip: !QuestionsCubit.get(context)
                          .getSelectedCardsList
                          .contains(4) &&
                      QuestionsCubit.get(context).canFlipImage,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlipCardWidget(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                            .getSelectedCardsList
                            .contains(3) &&
                        QuestionsCubit.get(context).canFlipImage) {
                      QuestionsCubit.get(context).setSelectedCardsList = 3;
                      QuestionsCubit.get(context).card3.flipcard();
                    }
                  },
                  controller: QuestionsCubit.get(context).card3,
                  image: Images.fileImagesPath + Constants.appleImage,
                  flip: !QuestionsCubit.get(context)
                          .getSelectedCardsList
                          .contains(4) &&
                      QuestionsCubit.get(context).canFlipImage,
                ),
                FlipCardWidget(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                            .getSelectedCardsList
                            .contains(4) &&
                        QuestionsCubit.get(context).canFlipImage) {
                      QuestionsCubit.get(context).setSelectedCardsList = 4;
                      QuestionsCubit.get(context).card4.flipcard();
                    }
                  },
                  controller: QuestionsCubit.get(context).card4,
                  image: Images.fileImagesPath + Constants.strawberryImage,
                  flip: !QuestionsCubit.get(context)
                          .getSelectedCardsList
                          .contains(4) &&
                      QuestionsCubit.get(context).canFlipImage,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
