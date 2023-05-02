import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';
import 'package:spot_finder/view-model/providers/text_field_provider.dart';
import 'package:spot_finder/view/map/widgets/buttons/container_button.dart';
import 'package:spot_finder/view/map/widgets/buttons/custom_alert_dialog.dart';
import '../buttons/custom_text_field.dart';
import 'categories_list.dart';

class CategoriesBuilder extends StatefulWidget {
  const CategoriesBuilder({
    super.key,
  });

  @override
  State<CategoriesBuilder> createState() => _CategoriesBuilderState();
}

class _CategoriesBuilderState extends State<CategoriesBuilder> {
  @override
  Widget build(BuildContext context) {
    final saveSpotProvider = Provider.of<SaveSpotProvider>(context);
    final textFieldProvider = Provider.of<TextFieldProvider>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                itemCount: saveSpotProvider.categoriesModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 1),
                itemBuilder: (context, index) {
                  return CategoriesList(
                    index: index,
                    categories: saveSpotProvider.categoriesModel[index],
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
                            errorText: textFieldProvider.returnError,
                            controller:
                                textFieldProvider.textEditingControllers[1],
                            value: saveSpotProvider.category,
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
