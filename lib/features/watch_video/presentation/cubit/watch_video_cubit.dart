import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:autiscope_app/core/utils/camera_config.dart';
import 'package:autiscope_app/core/widgets/convert_image.dart';
import 'package:autiscope_app/features/watch_video/domain/usecase/check_for_autism_usecase.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as imgee;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:path_provider/path_provider.dart';

part 'watch_video_state.dart';

class WatchVideoCubit extends Cubit<WatchVideoState> {
  static WatchVideoCubit get(BuildContext context) => BlocProvider.of(context);

  WatchVideoCubit({required this.checkForAutismUseCase})
      : super(WatchVideoInitial());

  final CheckForAutismUseCase checkForAutismUseCase;

  final ExamCameraService _examCameraService = ExamCameraService();
  late CameraImage cameraImage;
  Timer? timer;

  initCamera() async {
    try {
      await _examCameraService.initCameras().then(
          (_) async => Future.delayed(const Duration(seconds: 2)).then((_) {
                try {
                  startCameraStream();
                } catch (e) {
                  startCameraStream();
                }
              }));
    } catch (e) {
      log("Failed to initialize camera: $e");
    }
  }

  Future<void> stopCameraStreaming() async {
    _examCameraService.getCameraController().dispose();
    timer!.cancel();
  }

  List<File> images = [];

  Future<void> startCameraStream() async {
    _examCameraService.getCameraController().startImageStream((image) {
      cameraImage = image;
    });
    timer = Timer.periodic(const Duration(seconds: 2), (t) async {
      final tempDir = await getTemporaryDirectory();
      File file = await File(
              '${tempDir.path}/image${DateTime.now().microsecondsSinceEpoch}.jpg')
          .create();
      Uint8List jpeg =
          Uint8List.fromList(imgee.encodeJpg(convertToImage(cameraImage)!));
      file.writeAsBytesSync(jpeg);
      await fixExifRotation(file.path);
      images.add(file);
      for (var element in images) {
        log('=======================================ddd ${element.path}');
      }
      base64Encode(file.readAsBytesSync());
    });
  }

  Future<void> checkForAutism({required bool parentQuestions}) async {
    emit(WatchVideoLoading());
    try {
      final response = await checkForAutismUseCase(
          CheckForAutismUseCaseParams(images: images));
      response.fold((failure) {
        log('====================================== failure ${failure.failure}');
        emit(WatchVideoError(failure: failure.toString()));
      }, (success) async {
        if ((parentQuestions && success.result) ||
            (parentQuestions && !success.result)) {
          log('========================================== ooo ${parentQuestions}');
          log('========================================== ooo ${success.result}');
          log('========================================== ooo ${success.precentage}');
          log('========================================== ooo ${(success.precentage * 0.70 + 0.30) > 0.50}');
          (success.precentage * 0.70 + 0.30) > 50
              ? emit(const WatchVideoLoaded(isSuccess: true))
              : emit(const WatchVideoLoaded(isSuccess: false));
        } else if (!parentQuestions && success.result) {
          emit(WatchVideoLoaded(isSuccess: (success.precentage * 0.70 > 0.50)));
        }
      });
    } catch (failure) {
      log('====================================== failure ${failure.toString()}');
      emit(WatchVideoError(failure: failure.toString()));
    }
  }

  void sendMail({required String text,required String email}) async {
    User? user = FirebaseAuth.instance.currentUser;
    String username = 'autiscope.app@gmail.com';
    String password = 'qquzwczvfkqnvsly';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'أوتِيسكوب Autiscope')
      ..recipients.add(user!.email!)
      ..subject = 'تقرير من أوتيسكوب'
      ..text = text;
    try {
      await send(message, smtpServer);
      log('Email sent successfully');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  String generateOTP() {
    const int otpLength = 6;
    final math.Random random = math.Random();
    List<int> digits = List.generate(otpLength, (index) => random.nextInt(10));
    String otp = digits.join('');
    return otp;
  }

  Future<void> clearCache() async {
    try {
      images.clear();
      Directory cacheDir = await getTemporaryDirectory();
      List<FileSystemEntity> entities = cacheDir.listSync(recursive: true);
      for (FileSystemEntity entity in entities) {
        if (entity is File) {
          await entity.delete();
        } else if (entity is Directory) {
          await entity.delete(recursive: true);
        }
      }
      print('Cache cleared successfully');
    } catch (e) {
      print('Failed to clear cache: $e');
    }
  }
}
