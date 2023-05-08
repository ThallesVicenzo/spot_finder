import 'package:flutter/material.dart';

import 'package:spot_finder/view/map/widgets/buttons/container_button.dart';
import 'package:spot_finder/view/map/widgets/buttons/custom_alert_dialog.dart';

import '../../../../view-model/providers/new_spot_providers/categories_provider.dart';
import '../../../../view-model/providers/new_spot_providers/save_spot_provider.dart';
import '../../../../view-model/providers/new_spot_providers/text_field_provider.dart';
import '../buttons/custom_text_field.dart';
import 'categories_list.dart';

class CategoriesBuilder extends StatefulWidget {
  const CategoriesBuilder({
    required this.categoriesProvider,
    required this.textFieldProvider,
    required this.saveSpotProvider,
    super.key,
  });

  final CategoriesProvider categoriesProvider;
  final SaveSpotProvider saveSpotProvider;
  final TextFieldProvider textFieldProvider;

  @override
  State<CategoriesBuilder> createState() => _CategoriesBuilderState();
}

class _CategoriesBuilderState extends State<CategoriesBuilder> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                itemCount: widget.categoriesProvider.categoriesModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 1),
                itemBuilder: (context, index) {
                  return CategoriesList(
                    index: index,
                    categories:
                        widget.categoriesProvider.categoriesModel[index],
                    saveSpotProvider: widget.saveSpotProvider,
                    textFieldProvider: widget.textFieldProvider,
                  );
                }),
          ),
          ContainerButton(
              title: 'Clique aqui para criar uma nova categoria.',
              fontSize: 15.0,
              function: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                          title: 'Escreva uma nova categoria.',
                          content: CustomTextField(
                            title: 'Nova categoria.',
                            errorText: widget.textFieldProvider.returnError,
                            controller: widget
                                .textFieldProvider.textEditingControllers[1],
                          ),
                          function: () {
                            Navigator.pop(context);
                          });
                    });
              }),
        ],
      ),
    );
  }
}
