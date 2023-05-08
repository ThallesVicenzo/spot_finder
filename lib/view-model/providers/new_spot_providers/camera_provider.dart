import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../view/camera/camera_screen.dart';

class CameraProvider with ChangeNotifier {
  late CameraController? cameraController;

  bool isFlashButtonClicked = false;
  bool isPictureTaken = false;

  ImageProvider<Object>? picture;

  Future<void> goToPictureScreen(context) async {
    final cameras = await availableCameras();

    Navigator.push(context,
        MaterialPageRoute(builder: (_) => CameraScreen(cameras: cameras)));
  }

  Future<void> initCamera(
    CameraDescription cameraDescription,
    bool mounted,
  ) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await cameraController!.initialize().then((_) {
        return;
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
    notifyListeners();
  }

  Future takePicture(context) async {
    if (!cameraController!.value.isInitialized) {
      return null;
    }
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      await setFlash();

      xFileToImage(await cameraController!.takePicture());

      isPictureTaken = true;

      cameraController!.setFlashMode(FlashMode.off);

      Navigator.pop(context);
    } on CameraException catch (e) {
      return debugPrint('$e');
    }
    notifyListeners();
  }

  Future<void> xFileToImage(XFile xFile) async {
    final Uint8List bytes = await xFile.readAsBytes();
    picture = Image.memory(bytes).image;
    notifyListeners();
  }

  Future<void> setFlash() async {
    if (!isFlashButtonClicked) {
      await cameraController!.setFlashMode(FlashMode.off);
    } else {
      await cameraController!.setFlashMode(FlashMode.torch);
    }
  }

  void changeFlashIcon() {
    isFlashButtonClicked = !isFlashButtonClicked;
    notifyListeners();
  }
}
