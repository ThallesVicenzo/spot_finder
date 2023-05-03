import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/view-model/providers/places_provider.dart';

import '../../../shared/constants.dart';
import '../../../view-model/providers/save_spot_provider.dart';
import '../../../view-model/providers/text_field_provider.dart';
import '../../../view-model/routes/named_routes.dart';

import '../../../view/map/widgets/buttons/custom_alert_dialog.dart';
import '../../../view/map/widgets/buttons/picture_button.dart';

import 'buttons/container_button.dart';
import 'buttons/custom_text_field.dart';
import 'categories/categories_builder.dart';

class SaveSpot extends StatefulWidget {
  const SaveSpot({super.key});

  @override
  State<SaveSpot> createState() => _SaveSpotState();
}

class _SaveSpotState extends State<SaveSpot> {
  @override
  Widget build(BuildContext context) {
    final saveSpotProvider = Provider.of<SaveSpotProvider>(context);
    final textFieldProvider = Provider.of<TextFieldProvider>(context);
    final placesProvider = Provider.of<PlacesProvider>(context);

    void customDispose() {
      saveSpotProvider.currentColor = Colors.red;
      saveSpotProvider.pressedIndex = -1;
      textFieldProvider.clearControllers();
      textFieldProvider.returnError = null;
      Navigator.popUntil(
          context, (route) => route.settings.name == NamedRoutes.map);
    }

    void validation() {
      textFieldProvider.errorText().then((text) {
        setState(() {
          textFieldProvider.returnError = text;
        });

        if (text == null) {
          saveSpotProvider.savePlace();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return CustomAlertDialog(
                    title: 'Sucesso!',
                    content: null,
                    function: () {
                      customDispose();
                    });
              });
        } else {
          setState(() {});
        }
      });
    }

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (_) {
              return CustomAlertDialog(
                  title: 'Tem certeza que quer voltar?',
                  content: null,
                  cancelButtonVisibility: true,
                  function: () {
                    customDispose();
                  });
            });
        return false;
      },
      child: Scaffold(
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
                      CustomTextField(
                        title: 'Nome',
                        controller: textFieldProvider.textEditingControllers[0],
                        errorText: textFieldProvider.returnError,
                        onChangedValue: saveSpotProvider.placeName,
                      ),
                      CustomTextField(
                        title: 'Categorias',
                        controller: textFieldProvider.textEditingControllers[1],
                        errorText: textFieldProvider.returnError,
                        readOnly: true,
                        onChangedValue: saveSpotProvider.category,
                        onTap: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext _) {
                                return FutureBuilder(
                                    future: saveSpotProvider.getCategories(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator(
                                          color: Theme.of(context).splashColor,
                                        ));
                                      }
                                      return CustomAlertDialog(
                                        title:
                                            'Por favor, escolha uma categoria.',
                                        content: const CategoriesBuilder(),
                                        function: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              });
                        },
                      ),
                      TextField(
                        controller: textFieldProvider.textEditingControllers[2],
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          labelText: 'Endereço',
                          labelStyle:
                              Theme.of(context).primaryTextTheme.bodySmall,
                          errorText: textFieldProvider.returnError,
                          border: kInputBorder.copyWith(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          focusedBorder: kInputBorder.copyWith(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          placesProvider.showPredictions(value);
                        },
                      ),
                      CustomTextField(
                        title: 'Cor do marcador',
                        onChangedValue: saveSpotProvider.markerColor,
                        controller: null,
                        sufixIcon: Icons.circle,
                        iconColor: saveSpotProvider.currentColor,
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
                                    saveSpotProvider.selectColor(value);
                                  },
                                  pickerColor: saveSpotProvider.currentColor,
                                ),
                                function: () {
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                      ),
                      ContainerButton(
                          title: 'Registrar o lugar',
                          fontSize: 20.0,
                          function: () {
                            validation();
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
