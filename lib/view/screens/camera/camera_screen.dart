import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/camera_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final camera = CameraProvider();

  @override
  void initState() {
    super.initState();
    camera.initCamera(widget.cameras![0], mounted);
  }

  @override
  void dispose() {
    camera.cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => camera,
          child: Consumer<CameraProvider>(
            builder: (_, markersProvider, __) => Stack(children: [
              (camera.cameraController.value.isInitialized)
                  ? CameraPreview(camera.cameraController)
                  : Container(
                      color: Colors.black,
                      child: const Center(child: CircularProgressIndicator())),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                        color: Colors.black),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 30,
                            icon: Icon(
                                camera.isRearCameraSelected
                                    ? CupertinoIcons.switch_camera
                                    : CupertinoIcons.switch_camera_solid,
                                color: Colors.white),
                            onPressed: () {
                              camera.switchCamera(widget.cameras, mounted);
                            },
                          )),
                          Expanded(
                              child: IconButton(
                            onPressed: () {
                              camera.takePicture(context);
                            },
                            iconSize: 50,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.circle, color: Colors.white),
                          )),
                          const Spacer(),
                        ]),
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
