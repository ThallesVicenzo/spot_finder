import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../view/screens/camera/camera_screen.dart';

class CameraProvider with ChangeNotifier {
  Future<void> goToPictureScreen(context) async {
    final cameras = await availableCameras();

    Navigator.push(context,
        MaterialPageRoute(builder: (_) => CameraScreen(cameras: cameras)));
  }

  late CameraController cameraController;
  bool isRearCameraSelected = true;
  bool isPictureTaken = false;
  XFile? picture;

  Future takePicture(context) async {
    if (!cameraController.value.isInitialized) {
      return null;
    }
    if (cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await cameraController.setFlashMode(FlashMode.off);
      picture = await cameraController.takePicture();
      !isPictureTaken;
      Navigator.pop(context);
    } on CameraException catch (e) {
      return debugPrint('aaaaaaaaaa error $e');
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

  void switchCamera(List<CameraDescription>? cameras, bool mounted) {
    isRearCameraSelected = isRearCameraSelected;
    initCamera(cameras![isRearCameraSelected ? 0 : 1], mounted);
    notifyListeners();
  }
}
