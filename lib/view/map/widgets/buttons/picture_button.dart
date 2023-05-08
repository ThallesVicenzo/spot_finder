import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../view-model/providers/camera_provider.dart';

class PictureButton extends StatelessWidget {
  const PictureButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Material(
      child: Consumer<CameraProvider>(
        builder: (context, cameraProvider, child) => InkWell(
          onTap: () {
            CameraProvider().goToPictureScreen(context);
          },
          child: SizedBox(
            height: size.height * 0.2,
            child: Container(
              color: theme.cardColor,
              child: cameraProvider.isPictureTaken
                  ? Stack(
                      children: [
                        Center(
                          child: Image(
                            image: ResizeImage(
                              cameraProvider.picture!,
                              height: (size.height * 0.3).toInt(),
                              width: (size.width).toInt(),
                            ),
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.camera_alt,
                            color: theme.primaryColor,
                            size: 45,
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 45,
                        color: theme.primaryColor,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
