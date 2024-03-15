import 'dart:async';
import 'dart:developer';

import 'package:autiscope_app/core/resources/resources.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
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

  final List<int> _selectedCardsList = [];

  List<int> get getSelectedCardsList => _selectedCardsList;

  set setSelectedCardsList(int card) {
    emit(SetAndGetValueLoading());
    _selectedCardsList.add(card);
    emit(SetAndGetValueLoaded());
  }

  List<String> answers = [];

  String childName = 'childName';
  String nicName = 'nicName';

  Future<void> flipImagesTimer() async {
    emit(SetAndGetValueLoading());
    await Future.delayed(const Duration(seconds: 10)).then((_) {
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

  Future<void> initSpeechToText() async {
    await SpeechToText().initialize();
  }

  Future<void> startSpeechListen() async {
    emit(SetAndGetValueLoading());
    final options = SpeechListenOptions(
        onDevice: false,
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
        partialResults: true,
        autoPunctuation: true,
        enableHapticFeedback: true);
    await SpeechToText().listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 15),
      pauseFor: const Duration(seconds: 15),
      localeId: 'ar_JO',
      listenOptions: options,
    );
    emit(SetAndGetValueLoaded());
  }

  Future<void> stopSpeechListen() async {
    await SpeechToText().stop();
    await SpeechToText().cancel();
  }

  String speechResult = '';

  void _onSpeechResult(SpeechRecognitionResult result) {
    speechResult = result.recognizedWords;
  }

  Future<void> childNameTimer() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 10) {
        timer.cancel();
        if (speechResult.contains(childName) ||
            speechResult.contains(nicName)) {
          answers.add(ModelsConstants.nonAutistic);
        } else {
          answers.add(ModelsConstants.autistic);
        }
        emit(ModelAnswerLoaded(answer: answers.first));
      }
    });
  }

  Future<void> checkMatchingQuestion(bool answer) async {
    emit(CharQuestionsLoading());
    if (answer) {
      answers.add(ModelsConstants.nonAutistic);
    } else {
      answers.add(ModelsConstants.autistic);
    }
    emit(ModelAnswerLoaded(
        answer:
            answer ? ModelsConstants.nonAutistic : ModelsConstants.autistic));
  }

  final List<int> _bearAnswers = [];

  List<int> get getBearAnswers => _bearAnswers;

  set setBearAnswers(int value) {
    emit(SetAndGetValueLoading());
    _bearAnswers.add(value);
    emit(SetAndGetValueLoaded());
  }

  Future<void> setBearQuestionTimer() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 45 || _bearAnswers.length == 3) {
        timer.cancel();
        if (_bearAnswers.length == 3) {
          answers.add(ModelsConstants.nonAutistic);
        } else {
          answers.add(ModelsConstants.autistic);
        }
        emit(BearGameFinishedLoaded());
      }
    });
  }

  Future<void> addFlipResult() async {
    if ((_selectedCardsList.first == 1 && _selectedCardsList[1] == 4) ||
        (_selectedCardsList.first == 2 && _selectedCardsList[1] == 3)) {
      answers.add(ModelsConstants.nonAutistic);
    } else {
      answers.add(ModelsConstants.autistic);
    }
  }

  double firstFourQuestionsResult() {
    double result = 0;
    if (answers[0].contains(ModelsConstants.autistic)) {
      result += .25;
    }
    if (answers[1].contains(ModelsConstants.autistic)) {
      result += .25;
    }
    if (answers[2].contains(ModelsConstants.autistic)) {
      result += .25;
    }
    if (answers[3].contains(ModelsConstants.autistic)) {
      result += .25;
    }
    return result * 0.30;
  }

  Future<double> sendResult() async {
    double result = firstFourQuestionsResult() +
        (answers[4] == ModelsConstants.autistic ? 0.10 : 0) +
        (answers[5] == ModelsConstants.autistic ? 0.05 : 0) +
        (answers[6] == ModelsConstants.autistic ? 0.05 : 0) +
        (answers[7] == ModelsConstants.autistic ? 0.20 : 0) +
        (answers[8] == ModelsConstants.autistic ? 0.30 : 0);
    return result;
  }
}
