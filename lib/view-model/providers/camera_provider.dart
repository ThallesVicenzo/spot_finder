import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../view/camera/camera_screen.dart';

class CameraProvider with ChangeNotifier {
  Future<void> goToPictureScreen(context) async {
    final cameras = await availableCameras();

    Navigator.push(context,
        MaterialPageRoute(builder: (_) => CameraScreen(cameras: cameras)));
  }

  late CameraController cameraController;

  bool isFlashButtonClicked = false;
  bool isPictureTaken = false;

  XFile? picture;
  ImageProvider<Object>? displayImage;

  Future takePicture(context) async {
    if (!cameraController.value.isInitialized) {
      return null;
    }
    if (cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await setFlash();
      picture = await cameraController.takePicture();

      !isPictureTaken;
      Navigator.of(context).pop(context);
    } on CameraException catch (e) {
      return debugPrint('$e');
    }
    notifyListeners();
  }

  Future initCamera(
    CameraDescription cameraDescription,
    bool mounted,
  ) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await cameraController.initialize().then((_) {
        return;
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
    notifyListeners();
  }

  Future<void> setFlash() async {
    if (!isFlashButtonClicked) {
      await cameraController.setFlashMode(FlashMode.off);
    } else {
      await cameraController.setFlashMode(FlashMode.torch);
    }
  }

  void changeFlashIcon() {
    isFlashButtonClicked = !isFlashButtonClicked;
    notifyListeners();
  }

  Future<void> xFileToImage(XFile? xFile) async {
    final Uint8List bytes = await xFile!.readAsBytes();
    displayImage = Image.memory(bytes).image;
    notifyListeners();
  }
}
