import 'package:spot_finder/model/models/predictions.dart';
import 'package:spot_finder/model/services/google_places_service.dart';

import '../../model/models/predictions_auto_complete.dart';
import '../../shared/constants.dart';

class PlacesRepository {
  Future<List<PredictionsModel>?> defineUri(String query) async {
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      'input': query,
      'key': kGooglePlacesApiKey,
    });

    String? response = await GooglePlacesService.fetchUrl(uri);
    if (response != null) {
      List<PredictionsModel> result =
          PlacesAutoCompleteModel.parseAutoCompleteModel(response)
              .predictions!
              .toList();
      return result;
    }
    return null;
  }
}
