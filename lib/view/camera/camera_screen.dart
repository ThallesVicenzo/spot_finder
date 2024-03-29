import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/new_spot_providers/show_picture_provider.dart';

import '../../view-model/providers/new_spot_providers/camera_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    final showPictureProvider = Provider.of<ShowPictureProvider>(context);

    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => CameraProvider(),
        child: SafeArea(
          child: Consumer<CameraProvider>(
            builder: (_, cameraProvider, __) => Stack(
              children: [
                FutureBuilder(
                    future: cameraProvider.initCamera(
                        cameraDescription: widget.cameras![0],
                        mounted: mounted),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          color: Colors.black,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).splashColor,
                            ),
                          ),
                        );
                      }
                      return CameraPreview(cameraProvider.cameraController!);
                    }),
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
                        const Spacer(),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              cameraProvider
                                  .takePicture(showPictureProvider)
                                  .whenComplete(
                                    () => Navigator.pop(context),
                                  );
                            },
                            iconSize: 50,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.circle, color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              cameraProvider.changeFlashIcon();
                            },
                            icon: Icon(
                              cameraProvider.isFlashButtonClicked
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
