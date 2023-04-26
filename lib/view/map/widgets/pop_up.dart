import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';
import 'package:spot_finder/view/map/widgets/buttons/categories_list.dart';
import 'package:spot_finder/view/map/widgets/buttons/custom_alert_dialog.dart';
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
                    CustomTextField(
                      title: 'Categorias',
                      readOnly: true,
                      onTap: () async {
                        await viewModel.getCategories();
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                title: 'Por favor, escolha uma categoria.',
                                content: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width,
                                  child: GridView.builder(
                                      itemCount:
                                          viewModel.categoriesModel.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 20,
                                              crossAxisSpacing: 10,
                                              childAspectRatio: 2 / 1),
                                      itemBuilder: (context, index) {
                                        return CategoriesList(
                                          index: index,
                                          categories:
                                              viewModel.categoriesModel[index],
                                        );
                                      }),
                                ),
                                function: () {
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                    ),
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
                            return CustomAlertDialog(
                              title:
                                  'Por favor, escolha uma cor para seu marcador.',
                              content: BlockPicker(
                                onColorChanged: (Color value) {
                                  viewModel.selectColor(value);
                                },
                                pickerColor: viewModel.currentColor,
                              ),
                              function: () {
                                Navigator.pop(context);
                              },
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
