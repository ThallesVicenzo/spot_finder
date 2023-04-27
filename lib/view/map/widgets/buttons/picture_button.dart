import 'package:flutter/material.dart';

import '../../../../view-model/providers/camera_provider.dart';

class PictureButton extends StatelessWidget {
  PictureButton({
    super.key,
  });

  final CameraProvider camera = CameraProvider();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          CameraProvider().goToPictureScreen(context);
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Container(
            color: Theme.of(context).cardColor,
            child: camera.isPictureTaken
                ? Stack(
                    children: [
                      Image(image: camera.displayImage!),
                      Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Theme.of(context).primaryColor,
                          size: 45,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 45,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
