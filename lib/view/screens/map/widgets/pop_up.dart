import 'package:flutter/material.dart';

import 'picture_button.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [PictureButton()],
      ),
    );
  }
}
