import 'package:spot_finder/model/services/google_places_service.dart';

import '../../model/models/places.dart';
import '../../shared/constants.dart';

class PlacesRepository {
  dynamic defineUri(String query) async {
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      'input': query,
      'key': kGooglePlacesApiKey,
    });
    String? response = await GooglePlacesService.fetchUrl(uri);
    if (response != null) {
      PlacesAutoCompleteModel result =
          PlacesAutoCompleteModel.placesAutoCompleteModel(response);
      if (result.predictions != null) {
        return result.predictions;
      }
    }
  }
}
