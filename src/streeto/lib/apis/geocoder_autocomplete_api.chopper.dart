// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoder_autocomplete_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$GeocoderAutocompleteApi extends GeocoderAutocompleteApi {
  _$GeocoderAutocompleteApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = GeocoderAutocompleteApi;

  Future<Response<SuggestionsResponse>> getSuggestions(
      {String appId = kHereApiAppId,
      String appCode = kHereApiAppCode,
      dynamic maxResults = 10,
      String query,
      String latLon}) {
    final $url = 'http://autocomplete.geocoder.api.here.com/6.2/suggest.json';
    final Map<String, dynamic> $params = {
      'app_id': appId,
      'app_code': appCode,
      'maxresults': maxResults,
      'query': query,
      'prox': latLon
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<SuggestionsResponse, SuggestionsResponse>($request);
  }
}
