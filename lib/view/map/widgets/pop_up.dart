import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';
import 'package:spot_finder/view/map/widgets/buttons/picture_button.dart';

import 'buttons/confirm_button.dart';
import 'buttons/custom_text_field.dart';

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SaveSpotProvider>(context);

    return Scaffold(
      body: Container(
        color: Theme.of(context).splashColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PictureButton(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    const CustomTextField(
                      title: 'Nome',
                    ),
                    const CustomTextField(title: 'Categorias'),
                    CustomTextField(
                      title: 'Endereço',
                      sufixIcon: Icons.pin_drop_sharp,
                      iconColor: viewModel.currentColor,
                    ),
                    CustomTextField(
                      title: 'Cor do marcador',
                      sufixIcon: Icons.circle,
                      iconColor: viewModel.currentColor,
                      readOnly: true,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Escolha uma cor para o marcador',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium,
                              ),
                              content: BlockPicker(
                                onColorChanged: (Color value) {
                                  viewModel.selectColor(value);
                                },
                                pickerColor: viewModel.currentColor,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Confirmar',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium,
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ConfirmButton(title: 'Registrar o lugar', function: () {})
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
