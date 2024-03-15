// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:autiscope_app/core/helpers/audio_player_helper.dart';
import 'package:autiscope_app/core/resources/contants.dart';
import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:autiscope_app/features/watch_video/presentation/cubit/watch_video_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindDifferenceScreen extends StatefulWidget {
  const FindDifferenceScreen({super.key});

  @override
  State<FindDifferenceScreen> createState() => _FindDifferenceScreenState();
}

class _FindDifferenceScreenState extends State<FindDifferenceScreen> {
  @override
  void initState() {
    AudioPlayerHelper.playAudio(path: Audios.findTheDifference);
    QuestionsCubit.get(context).setBearQuestionTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsCubit, QuestionsState>(
        listener: (context, state) async {
      if (state is BearGameFinishedLoaded) {
        if (await QuestionsCubit.get(context).sendResult() < 0.5) {
          WatchVideoCubit.get(context).sendMail(
              text: Strings.positiveRepost,
              email: LoginCubit.get(context).userId);
        } else {
          WatchVideoCubit.get(context).sendMail(
              text: Strings.negativeRepost,
              email: LoginCubit.get(context).userId);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم ارسال النتيجه عبر البريد الالكتروني'),
          ),
        );
        Navigator.of(context).pushReplacementNamed(Routes.addChildScreen);
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Center(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: FileImage(
              File(Images.fileImagesPath + Constants.bearsImage),
            ),
          )),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.translate(
                offset: const Offset(-19, -230),
                child: GestureDetector(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                        .getBearAnswers
                        .contains(1)) {
                      QuestionsCubit.get(context).setBearAnswers = 1;
                    }
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.star,
                      color:
                          QuestionsCubit.get(context).getBearAnswers.contains(1)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(-9, 135),
                child: GestureDetector(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                        .getBearAnswers
                        .contains(1)) {
                      QuestionsCubit.get(context).setBearAnswers = 1;
                    }
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.star,
                      color:
                          QuestionsCubit.get(context).getBearAnswers.contains(1)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(25, 272),
                child: GestureDetector(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                        .getBearAnswers
                        .contains(2)) {
                      QuestionsCubit.get(context).setBearAnswers = 2;
                    }
                  },
                  child: Container(
                    width: 55,
                    height: 64,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.star,
                      color:
                          QuestionsCubit.get(context).getBearAnswers.contains(2)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(13, -90),
                child: GestureDetector(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                        .getBearAnswers
                        .contains(2)) {
                      QuestionsCubit.get(context).setBearAnswers = 2;
                    }
                  },
                  child: Container(
                    width: 55,
                    height: 64,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.star,
                      color:
                          QuestionsCubit.get(context).getBearAnswers.contains(2)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(60, 207),
                child: GestureDetector(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                        .getBearAnswers
                        .contains(3)) {
                      QuestionsCubit.get(context).setBearAnswers = 3;
                    }
                  },
                  child: Container(
                    width: 43,
                    height: 47,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.star,
                      color:
                          QuestionsCubit.get(context).getBearAnswers.contains(3)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(45, -158),
                child: GestureDetector(
                  onTap: () {
                    if (!QuestionsCubit.get(context)
                        .getBearAnswers
                        .contains(3)) {
                      QuestionsCubit.get(context).setBearAnswers = 3;
                    }
                  },
                  child: Container(
                    width: 43,
                    height: 47,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.star,
                      color:
                          QuestionsCubit.get(context).getBearAnswers.contains(3)
                              ? Colors.white
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}
