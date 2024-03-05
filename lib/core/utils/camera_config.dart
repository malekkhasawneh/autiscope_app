import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';

class ExamCameraService {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  Future<void>? _initializeControllerFuture;
  ResolutionPreset? _resolutionPreset;

  ExamCameraService({ResolutionPreset? resolutionPreset}) {
    _resolutionPreset = resolutionPreset ?? ResolutionPreset.low;
  }

  Future<void> initCameras() async {
    try {
      _cameras = await availableCameras();
      _cameraController = CameraController(_cameras![1], _resolutionPreset!);
      _initializeControllerFuture = _cameraController!.initialize();
      log('=================================== init success');
    } catch (e) {
      log("Failed to initialize camera: $e");
    }
  }

  Future<void> dispose() async {
    await _cameraController!.dispose();
  }

  List<CameraDescription> getCameras() {
    return _cameras!;
  }

  CameraController getCameraController() {
    _cameraController!.setFlashMode(FlashMode.off);
    return _cameraController!;
  }


  Future<void>? get initializeControllerFuture => _initializeControllerFuture;
}
