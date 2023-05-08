import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view-model/providers/new_spot_providers/predictions_provider.dart';

class PredictionsList extends StatefulWidget {
  const PredictionsList({
    super.key,
  });

  @override
  State<PredictionsList> createState() => _PredictionsListState();
}

class _PredictionsListState extends State<PredictionsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Consumer<PredictionsProvider>(
        builder: (context, placesProvider, child) => Visibility(
          visible: placesProvider.returnVisibility(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: placesProvider.list!.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      placesProvider.onClickVisibility();
                    },
                    child: Text(
                      placesProvider.list![index].description!,
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
