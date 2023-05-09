import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/new_spot_providers/text_field_provider.dart';

import '../../../view-model/providers/new_spot_providers/predictions_provider.dart';

class PredictionsList extends StatefulWidget {
  const PredictionsList({
    super.key,
    required this.textFieldProvider,
  });

  final TextFieldProvider textFieldProvider;

  @override
  State<PredictionsList> createState() => _PredictionsListState();
}

class _PredictionsListState extends State<PredictionsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Consumer<PredictionsProvider>(
        builder: (context, predictionsProvider, child) => Visibility(
          visible: predictionsProvider.returnVisibility(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: predictionsProvider.list!.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    onPressed: () {
                      predictionsProvider.changeTextFieldValue(
                          widget.textFieldProvider, index);
                      predictionsProvider.onClickVisibility();
                    },
                    child: Text(
                      predictionsProvider.list![index].description!,
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
