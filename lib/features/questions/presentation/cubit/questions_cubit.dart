import 'dart:async';
import 'dart:developer';

import 'package:autiscope_app/core/resources/resources.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:tflite_audio/tflite_audio.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  static QuestionsCubit get(BuildContext context) => BlocProvider.of(context);

  QuestionsCubit() : super(CharQuestionsInitial());

  bool _recording = false;

  bool get getRecording => false;

  set setRecording(bool value) {
    emit(SetAndGetValueLoading());
    _recording = value;
    emit(SetAndGetValueLoaded());
  }

  FlipCardController card1 = FlipCardController();
  FlipCardController card2 = FlipCardController();
  FlipCardController card3 = FlipCardController();
  FlipCardController card4 = FlipCardController();

  bool canFlipImage = false;

  List<int> _selectedCardsList = [];

  List<int> get getSelectedCardsList => _selectedCardsList;

  set setSelectedCardsList(int card) {
    emit(SetAndGetValueLoading());
    _selectedCardsList.add(card);
    emit(SetAndGetValueLoaded());
  }

  List<String> answers = [];

  Future<void> flipImagesTimer() async {
    emit(SetAndGetValueLoading());
    await Future.delayed(const Duration(seconds: 15)).then((_) {
      card1.flipcard();
      card2.flipcard();
      card3.flipcard();
      card4.flipcard();
      canFlipImage = true;
    });
    emit(SetAndGetValueLoaded());
  }

  Stream<Map<dynamic, dynamic>>? result;

  Future<void> initModel({required String model}) async {
    emit(SetAndGetValueLoading());
    TfliteAudio.loadModel(
        model: model,
        label: ModelsConstants.labels,
        inputType: ModelsConstants.audioType,
        numThreads: 1,
        isAsset: true);
  }

  Future<void> recorder() async {
    emit(CharQuestionsLoading());
    String recognition = "";
    if (!_recording) {
      setRecording = true;
      result = TfliteAudio.startAudioRecognition(
        sampleRate: 44100,
        bufferSize: 22016,
        numOfInferences: 5,
        detectionThreshold: 0.3,
      );
      result?.listen((event) {
        recognition = event["recognitionResult"];
      }).onDone(() {
        log('================================ result $recognition');
        answers.add(recognition);
        stopListening();
        setRecording = false;
        emit(ModelAnswerLoaded(answer: recognition));
      });
    }
  }

  Future<void> stopListening() async {
    TfliteAudio.stopAudioRecognition();
  }
}