import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/model/models/categories.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';
import 'package:spot_finder/view-model/providers/text_field_provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.index,
  });

  final CategoriesModel categories;
  final int index;
  @override
  Widget build(BuildContext context) {
    final saveSpotProvider = Provider.of<SaveSpotProvider>(context);
    final textFieldProvider = Provider.of<TextFieldProvider>(context);

    return InkWell(
      onTap: () {
        saveSpotProvider.onCategoryButtonTap(index);
        saveSpotProvider.category = categories.categories;
        textFieldProvider.updateCategoryValue(saveSpotProvider.category);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: saveSpotProvider.changeCategorieButtonColor(context, index),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            categories.categories,
            style: Theme.of(context)
                .primaryTextTheme
                .bodySmall!
                .copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
