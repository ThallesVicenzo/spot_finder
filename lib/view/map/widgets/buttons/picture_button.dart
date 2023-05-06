import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view-model/providers/camera_provider.dart';

class PictureButton extends StatelessWidget {
  const PictureButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<CameraProvider>(
        builder: (context, cameraProvider, child) => InkWell(
          onTap: () {
            CameraProvider().goToPictureScreen(context);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              color: Theme.of(context).cardColor,
              child: cameraProvider.isPictureTaken
                  ? Stack(
                      children: [
                        Center(
                          child: Image(
                            image:
                                XFileImage(cameraProvider.picture!, scale: 0.1),
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                        ),
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
      ),
    );
  }
}
