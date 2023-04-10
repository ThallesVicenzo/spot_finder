import 'package:cross_file_image/cross_file_image.dart';
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
              color: Colors.grey,
              child: camera.isPictureTaken
                  ? Stack(
                      children: [
                        Image(image: XFileImage(camera.picture!)),
                        Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: Theme.of(context).primaryColor,
                            size: 45,
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 45,
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
        ),
      ),
    );
  }
}
