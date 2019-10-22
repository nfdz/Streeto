import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:streeto/common/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geocoder_autocomplete_api.g.dart';
part "geocoder_autocomplete_api.chopper.dart";

// Any change here run -> flutter packages pub run build_runner build --delete-conflicting-outputs
@ChopperApi(baseUrl: "http://autocomplete.geocoder.api.here.com/6.2/suggest.json")
abstract class GeocoderAutocompleteApi extends ChopperService {
  static GeocoderAutocompleteApi create([ChopperClient client]) => _$GeocoderAutocompleteApi(client);

  @Get()
  Future<Response<SuggestionsResponse>> getSuggestions({
    @Query("app_id") String appId = kHereApiAppId,
    @Query("app_code") String appCode = kHereApiAppCode,
    @Query("maxresults") maxResults = 10,
    @Query("query") String query,
    @Query("prox") String latLon,
  });

  static String formatLatLong(double lat, double lon) => "$lat,$lon";
}

// GeocoderAutocompleteApi DTOs

@JsonSerializable()
class SuggestionsResponse {
  final List<SuggestionEntry> suggestions;
  SuggestionsResponse(this.suggestions);
  static const fromJsonFactory = _$SuggestionsResponseFromJson;
  static SuggestionsResponse fromJson(Map<String, dynamic> json) => _$SuggestionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionsResponseToJson(this);
}

@JsonSerializable()
class SuggestionEntry {
  final String label;
  final String locationId;
  final double distance;
  SuggestionEntry(this.label, this.locationId, this.distance);
  static const fromJsonFactory = _$SuggestionEntryFromJson;
  static SuggestionEntry fromJson(Map<String, dynamic> json) => _$SuggestionEntryFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionEntryToJson(this);

  bool operator ==(other) => (other is SuggestionEntry &&
      other.label == label &&
      other.locationId == locationId &&
      other.distance == distance);

  int get hashCode => label.hashCode + locationId.hashCode + distance.hashCode;
}

@JsonSerializable()
class ResponseError {
  final String error;
  @JsonKey(name: 'error_description')
  final String errorDescription;
  ResponseError(this.error, this.errorDescription);
  static const fromJsonFactory = _$ResponseErrorFromJson;
  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);
  @override
  String toString() => "ResponseError(error: $error, error_description: $errorDescription)";
}
