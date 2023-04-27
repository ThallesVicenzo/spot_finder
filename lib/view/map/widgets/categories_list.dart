import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/model/models/categories.dart';
import 'package:spot_finder/view-model/providers/save_spot_provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.index,
  });

  final Categories categories;
  final int index;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SaveSpotProvider>(context);

    return InkWell(
      onTap: () {
        viewModel.onCategoryButtonTap(index);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: viewModel.changeCategorieButtonColor(context, index),
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
