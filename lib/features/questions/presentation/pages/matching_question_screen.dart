import 'dart:io';

import 'package:autiscope_app/core/helpers/audio_player_helper.dart';
import 'package:autiscope_app/core/resources/contants.dart';
import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchingQuestionScreen extends StatefulWidget {
  @override
  _MatchingQuestionScreenState createState() => _MatchingQuestionScreenState();
}

class _MatchingQuestionScreenState extends State<MatchingQuestionScreen> {
  List<Offset?> points = [];
  List<bool> checkList = [];

  @override
  void initState() {
    AudioPlayerHelper.playAudio(path: Audios.matchingAudio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionsCubit, QuestionsState>(
      listener: (context, state) {
        if(state is ModelAnswerLoaded){
          if(state.answer.isNotEmpty){
            Future.delayed(const Duration(seconds: 1)).then((_) =>
                Navigator.pushReplacementNamed(
                    context, Routes.catQuestionScreen));
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              right: 2,
              top: 10,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(
                          File(Images.fileImagesPath + Constants.motherImage)),
                      fit: BoxFit.cover),
                ),
                width: 100,
                height: 200,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(
                          File(Images.fileImagesPath + Constants.childImage)),
                      fit: BoxFit.cover),
                ),
                width: 100,
                height: 200,
              ),
            ),
            GestureDetector(
              onPanUpdate: (details) {
                if ((details.localPosition.dy >=
                            MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.bottom -
                                MediaQuery.of(context).padding.top -
                                AppBar().preferredSize.height -
                                80 &&
                        details.localPosition.dx <= 90) ||
                    (details.localPosition.dx >=
                            MediaQuery.of(context).size.width -
                                MediaQuery.of(context).padding.left -
                                MediaQuery.of(context).padding.right -
                                90 &&
                        details.localPosition.dy <= 200)) {
                  setState(() {
                    checkList.add(true);
                  });
                } else {
                  setState(() {
                    checkList.add(false);
                  });
                }
                setState(() {
                  points.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                QuestionsCubit.get(context)
                    .checkMatchingQuestion(checkList.first && checkList.last);
              },
              onPanStart: (details) {
                points.clear();
                checkList.isNotEmpty ? checkList.clear() : checkList;
                setState(() {}); // Add null to indicate end of drawing
              },
              child: CustomPaint(
                painter: DrawingPainter(points: points),
                size: Size.infinite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
            points[i]!, points[i + 1]!, paint); // Access non-null values
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
