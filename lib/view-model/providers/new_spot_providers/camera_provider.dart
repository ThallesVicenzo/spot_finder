import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/new_spot_providers/show_picture_provider.dart';

import '../../../view/camera/camera_screen.dart';

class CameraProvider with ChangeNotifier {
  CameraController? cameraController;

  bool isFlashButtonClicked = false;

  ImageProvider<Object>? picture;

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
      await setFlash();

      _xFileToImage(await cameraController!.takePicture(), showPictureProvider);

      cameraController!.setFlashMode(FlashMode.off);

      showPictureProvider.isPictureTaken = true;
      showPictureProvider.notifyListeners();
    } on CameraException catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }

  Future<void> _xFileToImage(
      XFile xFile, ShowPictureProvider showPictureProvider) async {
    final Uint8List bytes = await xFile.readAsBytes();
    picture = Image.memory(bytes).image;
    showPictureProvider.picture = picture;
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
