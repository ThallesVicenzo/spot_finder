import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../../../shared/constants.dart';
import '../../../shared/debounce.dart';

import '../../../view-model/providers/new_spot_providers/show_picture_provider.dart';
import '../../../view-model/providers/new_spot_providers/categories_provider.dart';
import '../../../view-model/providers/new_spot_providers/predictions_provider.dart';
import '../../../view-model/providers/new_spot_providers/save_spot_provider.dart';
import '../../../view-model/providers/new_spot_providers/select_colors_provider.dart';
import '../../../view-model/providers/new_spot_providers/text_field_provider.dart';

import '../../../view-model/routes/named_routes.dart';
import '../../../view/map/widgets/buttons/custom_alert_dialog.dart';
import '../../../view/map/widgets/buttons/picture_button.dart';
import '../../../view/map/widgets/predictions_list.dart';

import 'buttons/container_button.dart';
import 'buttons/custom_text_field.dart';
import 'categories/categories_builder.dart';

class SaveSpot extends StatefulWidget {
  const SaveSpot({super.key, required this.lat, required this.long});

  final double lat;
  final double long;

  @override
  State<SaveSpot> createState() => _SaveSpotState();
}

class _SaveSpotState extends State<SaveSpot> {
  final debounce = Debounce();
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    final theme = Theme.of(context);
    final pictureProvider = Provider.of<ShowPictureProvider>(context);
    final textFieldProvider = Provider.of<TextFieldProvider>(context);

    final categoriesProvider = Provider.of<CategoriesProvider>(context);

    void resetValues() {
      pictureProvider.picture = null;
      pictureProvider.isPictureTaken = false;

      textFieldProvider.clearControllers();

      categoriesProvider.pressedIndex = -1;

      Navigator.popUntil(
          context, (route) => route.settings.name == NamedRoutes.map);
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaveSpotProvider()),
        ChangeNotifierProvider(create: (_) => PredictionsProvider()),
        ChangeNotifierProvider(create: (_) => SelectColorsProvider()),
      ],
      builder: (context, _) => WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (_) {
                return CustomAlertDialog(
                    title: 'Tem certeza que quer voltar?',
                    content: null,
                    cancelButtonVisibility: true,
                    function: () {
                      resetValues();
                    });
              });
          return false;
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Consumer<SaveSpotProvider>(
              builder: (_, saveSpotProvider, child) => Container(
                color: theme.splashColor,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const PictureButton(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Consumer<TextFieldProvider>(
                          builder: (_, textFieldProvider, child) => Column(
                            children: [
                              CustomTextField(
                                title: 'Nome',
                                controller:
                                    textFieldProvider.textEditingControllers[0],
                                errorText: textFieldProvider.returnError,
                              ),
                              Consumer<CategoriesProvider>(
                                builder: (_, categoriesProvider, __) =>
                                    CustomTextField(
                                  title: 'Categorias',
                                  controller: textFieldProvider
                                      .textEditingControllers[1],
                                  errorText: textFieldProvider.returnError,
                                  readOnly: true,
                                  onTap: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (BuildContext _) {
                                          return FutureBuilder(
                                              future: categoriesProvider
                                                  .getCategories(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: theme.splashColor,
                                                  ));
                                                }
                                                return CustomAlertDialog(
                                                  title:
                                                      'Por favor, escolha uma categoria.',
                                                  content: CategoriesBuilder(
                                                    saveSpotProvider:
                                                        saveSpotProvider,
                                                    categoriesProvider:
                                                        categoriesProvider,
                                                    textFieldProvider:
                                                        textFieldProvider,
                                                  ),
                                                  function: () {
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              });
                                        });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Consumer<PredictionsProvider>(
                                  builder: (_, placesProvider, __) => TextField(
                                    controller: textFieldProvider
                                        .textEditingControllers[2],
                                    textInputAction: TextInputAction.search,
                                    decoration: InputDecoration(
                                      labelText: 'Endereço',
                                      labelStyle:
                                          theme.primaryTextTheme.bodySmall,
                                      errorText: textFieldProvider.returnError,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          textFieldProvider
                                              .textEditingControllers[2]
                                              .clear();
                                          placesProvider.list!.clear();
                                          placesProvider.onClickVisibility();
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: theme.primaryColor,
                                          size: 25,
                                        ),
                                      ),
                                      border: kInputBorder.copyWith(
                                        borderSide: BorderSide(
                                          color: theme.primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      focusedBorder: kInputBorder.copyWith(
                                        borderSide: BorderSide(
                                          color: theme.primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      debounce.handle(() {
                                        placesProvider
                                            .showPredictions(value)
                                            .then((value) {
                                          scrollController.animateTo(
                                            200.0,
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve: Curves.linear,
                                          );
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ),
                              PredictionsList(
                                textFieldProvider: textFieldProvider,
                              ),
                              CustomTextField(
                                title: 'Descrição',
                                errorText: textFieldProvider.returnError,
                                action: TextInputAction.newline,
                                controller:
                                    textFieldProvider.textEditingControllers[3],
                                maxLines: 5,
                                minLines: 3,
                                sufixIcon: Icons.clear,
                                iconColor: theme.primaryColor,
                                sufixIconFunction: () {
                                  textFieldProvider.textEditingControllers[3]
                                      .clear();
                                },
                              ),
                              Consumer<SelectColorsProvider>(
                                builder: (_, selectColorsProvider, child) =>
                                    CustomTextField(
                                  title: 'Cor do marcador',
                                  controller: null,
                                  sufixIcon: Icons.pin_drop_sharp,
                                  iconColor: selectColorsProvider.currentColor,
                                  readOnly: true,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext _) {
                                        return CustomAlertDialog(
                                          title:
                                              'Por favor, escolha uma cor para seu marcador.',
                                          content: BlockPicker(
                                            onColorChanged: (Color value) {
                                              selectColorsProvider
                                                  .selectColor(value);
                                            },
                                            pickerColor: selectColorsProvider
                                                .currentColor,
                                          ),
                                          function: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              ContainerButton(
                                title: 'Registrar o lugar',
                                fontSize: 20.0,
                                function: () {
                                  saveSpotProvider.validation(
                                    context: context,
                                    textFieldProvider: textFieldProvider,
                                    widget: CustomAlertDialog(
                                      title: 'Você tem certeza?',
                                      content: null,
                                      function: () {
                                        saveSpotProvider.savePlace(
                                          context,
                                          widget.lat,
                                          widget.long,
                                        );
                                        resetValues();
                                      },
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
