import 'package:chopper/chopper.dart';
import 'package:streeto/apis/chopper_json_integration.dart';
import 'package:streeto/apis/geocoder_api.dart';
import 'package:streeto/apis/geocoder_autocomplete_api.dart';

class ChopperApiProvider {
  static GeocoderAutocompleteApi provideGeocoderAutocomplete() {
    final converter = JsonSerializableConverter({
      SuggestionEntry: SuggestionEntry.fromJsonFactory,
      SuggestionsResponse: SuggestionsResponse.fromJsonFactory,
    });
    final chopper = ChopperClient(
      services: [GeocoderAutocompleteApi.create()],
      converter: converter,
      errorConverter: converter,
    );
    return GeocoderAutocompleteApi.create(chopper);
  }

  static GeocoderApi provideGeocoder() {
    final converter = JsonSerializableConverter({
      DetailsResponse: DetailsResponse.fromJsonFactory,
      ResponseContent: ResponseContent.fromJsonFactory,
      View: View.fromJsonFactory,
      Result: Result.fromJsonFactory,
      LocationResult: LocationResult.fromJsonFactory,
      DisplayPosition: DisplayPosition.fromJsonFactory,
      Address: Address.fromJsonFactory,
    });
    final chopper = ChopperClient(
      services: [GeocoderApi.create()],
      converter: converter,
      errorConverter: converter,
    );
    return GeocoderApi.create(chopper);
  }
}
