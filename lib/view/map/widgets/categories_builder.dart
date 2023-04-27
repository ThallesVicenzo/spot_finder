import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';
import 'package:spot_finder/view-model/providers/text_field_provider.dart';
import 'buttons/custom_text_field.dart';
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
          CustomTextField(
            title: 'Nova Categoria',
            controller: textFieldProvider.textEditingControllers[2],
            value: saveSpotProvider.category,
          )
        ],
      ),
    );
  }
}
