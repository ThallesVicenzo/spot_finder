import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:spot_finder/view-model/providers/new_spot_providers/show_picture_provider.dart';

import '../../../view/camera/camera_screen.dart';

class CameraProvider with ChangeNotifier {
  CameraController? cameraController;

  bool isFlashButtonClicked = false;

  Future<void> goToPictureScreen(context) async {
    final cameras = await availableCameras();

    Navigator.push(context,
        MaterialPageRoute(builder: (_) => CameraScreen(cameras: cameras)));
  }

  Future<void> initCamera({
    required CameraDescription cameraDescription,
    required bool mounted,
  }) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      return cameraController!.initialize();
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
    notifyListeners();
  }

  Future takePicture(ShowPictureProvider showPictureProvider) async {
    if (!cameraController!.value.isInitialized) {
      return null;
    }
    if (cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      showPictureProvider.isPictureTaken = true;

      await setFlash();

      await _xFileToImage(
          await cameraController!.takePicture(), showPictureProvider);
    } on CameraException catch (e) {
      throw Exception(e);
    }
    showPictureProvider.notifyListeners();
  }

  Future<void> _xFileToImage(
      XFile xFile, ShowPictureProvider showPictureProvider) async {
    final Uint8List bytes = await xFile.readAsBytes();
    showPictureProvider.picture = Image.memory(bytes).image;
  }

  Future<void> setFlash() async {
    if (isFlashButtonClicked) {
      await cameraController!.setFlashMode(FlashMode.torch);
      print('com flash');
    } else {
      print('sem flash');
      await cameraController!.setFlashMode(FlashMode.off);
    }
  }

  void changeFlashIcon() {
    isFlashButtonClicked = !isFlashButtonClicked;
    notifyListeners();
  }
}
