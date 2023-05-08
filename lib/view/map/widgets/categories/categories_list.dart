import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/model/models/categories.dart';

import '../../../../view-model/providers/new_spot_providers/categories_provider.dart';
import '../../../../view-model/providers/new_spot_providers/save_spot_provider.dart';
import '../../../../view-model/providers/new_spot_providers/text_field_provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.index,
    required this.saveSpotProvider,
    required this.textFieldProvider,
  });

  final CategoriesModel categories;
  final int index;
  final SaveSpotProvider saveSpotProvider;
  final TextFieldProvider textFieldProvider;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, categoriesProvider, child) => InkWell(
        onTap: () {
          categoriesProvider.onCategoryButtonTap(index);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  categoriesProvider.changeCategorieButtonColor(context, index),
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
      ),
    );
  }
}
