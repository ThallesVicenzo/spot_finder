import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:spot_finder/shared/debounce.dart';

import 'package:spot_finder/view/map/widgets/predictions_list.dart';

import '../../../shared/constants.dart';
import '../../../view-model/providers/new_spot_providers/camera_provider.dart';
import '../../../view-model/providers/new_spot_providers/categories_provider.dart';
import '../../../view-model/providers/new_spot_providers/predictions_provider.dart';
import '../../../view-model/providers/new_spot_providers/save_spot_provider.dart';
import '../../../view-model/providers/new_spot_providers/select_colors_provider.dart';
import '../../../view-model/providers/new_spot_providers/text_field_provider.dart';

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
  final debounce = Debounce();
  final scrollController = ScrollController();
  final cameraProvider = CameraProvider();

  @override
  void dispose() {
    scrollController.dispose();
    cameraProvider.cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    final cameraProvider = Provider.of<CameraProvider>(context);
    final categoriesProvider = Provider.of<CategoriesProvider>(context);

    void resetValues() {
      cameraProvider.picture = null;
      cameraProvider.isPictureTaken = false;

      categoriesProvider.pressedIndex = -1;
      Navigator.popUntil(
          context, (route) => route.settings.name == NamedRoutes.map);
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SaveSpotProvider()),
        ChangeNotifierProvider(create: (_) => TextFieldProvider()),
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
                color: Theme.of(context).splashColor,
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
                                                    color: Theme.of(context)
                                                        .splashColor,
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
                                      labelStyle: Theme.of(context)
                                          .primaryTextTheme
                                          .bodySmall,
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
                                          color: Theme.of(context).primaryColor,
                                          size: 25,
                                        ),
                                      ),
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
                                      debounce.handle(() {
                                        placesProvider
                                            .showPredictions(value)
                                            .then((value) {
                                          scrollController.animateTo(
                                            200.0,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.linear,
                                          );
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ),
                              PredictionsList(
                                  textFieldProvider: textFieldProvider),
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
                                    saveSpotProvider: saveSpotProvider,
                                    textFieldProvider: textFieldProvider,
                                    widget: CustomAlertDialog(
                                      title: 'Sucesso!',
                                      content: null,
                                      function: () {
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
