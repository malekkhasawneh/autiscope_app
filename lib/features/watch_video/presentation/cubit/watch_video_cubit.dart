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

  initCamera() {
    try {
      _examCameraService.initCameras().then((_) {
        _examCameraService.initializeControllerFuture?.then((_) {});
      });
    } catch (e) {
      log("Failed to initialize camera: $e");
    }
  }

  void stopCameraStreaming() {
    _examCameraService.getCameraController().stopImageStream();
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

  Future<void> checkForAutism() async {
    emit(WatchVideoLoading());
    try {
      final response = await checkForAutismUseCase(
          CheckForAutismUseCaseParams(images: images));
      response.fold((failure) {
        log('====================================== failure ${failure.failure}');
        emit(WatchVideoError(failure: failure.toString()));
      }, (success) {
        log('====================================== success ${success.response}');
        log('====================================== success ${success.result}');
        log('====================================== success ${success.percentage}');
        emit(WatchVideoLoaded());
      });
    } catch (failure) {
      log('====================================== failure ${failure.toString()}');
      emit(WatchVideoError(failure: failure.toString()));
    }
  }

  void sendMail({required String subject,required String text}) async {
    String username = 'autiscope.app@gmail.com';
    String password = 'qquzwczvfkqnvsly';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'أوتِيسكوب Autiscope')
      ..recipients.add('malekmamoon341@gmail.com')
      ..subject = subject
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
}
