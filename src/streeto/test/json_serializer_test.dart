import 'dart:convert';

import 'package:test/test.dart';
import 'package:streeto/apis/geocoder_api.dart';
import 'package:streeto/apis/geocoder_autocomplete_api.dart';

// Suggestions JSON output for:
// query=Pariser+1+Berl
// prox=52.5267361,13.4409936
const int jsonSuggestionsTestCount = 4;
const String jsonSuggestionsTest = """
{"suggestions":[{"label":"Deutschland, Berlin, Berlin, 10117, Berlin, Pariser Platz 1","language":"de","countryCode":"DEU","locationId":"NT_5mGkj3z90Fbj4abzMbUE4C_xA","address":{"country":"Deutschland","state":"Berlin","county":"Berlin","city":"Berlin","district":"Mitte","street":"Pariser Platz","houseNumber":"1","postalCode":"10117"},"distance":4355,"matchLevel":"houseNumber"},{"label":"Deutschland, Berlin, Berlin, 10719, Berlin, Pariser Straße 1","language":"de","countryCode":"DEU","locationId":"NT_O4NUM-pb1nBQVGPJmz6ynA_xA","address":{"country":"Deutschland","state":"Berlin","county":"Berlin","city":"Berlin","district":"Wilmersdorf","street":"Pariser Straße","houseNumber":"1","postalCode":"10719"},"distance":8463,"matchLevel":"houseNumber"},{"label":"Deutschland, Berlin, Berlin, 12623, Berlin, Pariser Straße 1","language":"de","countryCode":"DEU","locationId":"NT_DhgBysiqGeVoRcX.IgLWJC_xA","address":{"country":"Deutschland","state":"Berlin","county":"Berlin","city":"Berlin","district":"Mahlsdorf","street":"Pariser Straße","houseNumber":"1","postalCode":"12623"},"distance":11295,"matchLevel":"houseNumber"},{"label":"Deutschland, Berlin, Berlin, 10243, Berlin, Straße der Pariser Kommune 1","language":"de","countryCode":"DEU","locationId":"NT_bD2VXvX6WIWNBOM8VFvXbA_xA","address":{"country":"Deutschland","state":"Berlin","county":"Berlin","city":"Berlin","district":"Friedrichshain","street":"Straße der Pariser Kommune","houseNumber":"1","postalCode":"10243"},"distance":1867,"matchLevel":"houseNumber"}]}
  """;

// Details JSON output for:
// locationid=NT_lWsc8knsFwVitNTFX88zmA_xAD
// (label -> UK, London, SW1A 2AA, London, 10 Downing Street)
const double jsonDetailsTestLat = 51.50341;
const double jsonDetailsTestLon = -0.12765;
const String jsonDetailsTestStreet = "Downing Street";
const String jsonDetailsTestPostalCode = "SW1A 2AA";
const String jsonDetailsTest = """
  {"response":{"metaInfo":{"timestamp":"2019-10-19T23:01:11.700+0000"},"view":[{"result":[{"relevance":0.0,"matchLevel":"houseNumber","matchType":"pointAddress","location":{"locationId":"NT_lWsc8knsFwVitNTFX88zmA_xAD","locationType":"address","displayPosition":{"latitude":51.50341,"longitude":-0.12765},"navigationPosition":[{"latitude":51.50322,"longitude":-0.12767}],"mapView":{"topLeft":{"latitude":51.5045342,"longitude":-0.129456},"bottomRight":{"latitude":51.5022858,"longitude":-0.125844}},"address":{"label":"10 Downing Street, London, SW1A 2AA, United Kingdom","country":"GBR","state":"England","county":"London","city":"London","district":"Westminster","street":"Downing Street","houseNumber":"10","postalCode":"SW1A 2AA","additionalData":[{"value":"United Kingdom","key":"CountryName"},{"value":"England","key":"StateName"},{"value":"London","key":"CountyName"}]}}}],"viewId":0}]}}
  """;

void main() {
  group('Story 1 Tests: JSON serializer', () {
    test('Test suggestions json deserialize', () {
      final response = SuggestionsResponse.fromJson(jsonDecode(jsonSuggestionsTest));
      expect(response.suggestions.length, jsonSuggestionsTestCount);
      for (SuggestionEntry entry in response.suggestions) {
        expect(entry.label != null, true);
        expect(entry.locationId != null, true);
        expect(entry.distance != null, true);
      }
    });
    test('Test suggestions json deserialize->serialize->deserialize and check origin and processed is the same', () {
      final responseOrigin = SuggestionsResponse.fromJson(jsonDecode(jsonSuggestionsTest));
      final responseJson = jsonEncode(responseOrigin.toJson());
      final responseProcessed = SuggestionsResponse.fromJson(jsonDecode(responseJson));
      expect(responseProcessed.suggestions.length, jsonSuggestionsTestCount);
      expect(responseOrigin.suggestions, responseProcessed.suggestions);
    });
  });

  group('Story 2 Tests: JSON serializer', () {
    test('Test details json deserialize', () {
      final response = DetailsResponse.fromJson(jsonDecode(jsonDetailsTest));
      final locationResult = response.response.view.first.result.first.location;
      _checkDetails(locationResult);
    });
    test('Test details json deserialize->serialize->deserialize and check origin and processed is the same', () {
      final responseOrigin = DetailsResponse.fromJson(jsonDecode(jsonDetailsTest));
      final responseJson = jsonEncode(responseOrigin.toJson());
      final responseProcessed = DetailsResponse.fromJson(jsonDecode(responseJson));
      final locationResult = responseProcessed.response.view.first.result.first.location;
      _checkDetails(locationResult);
    });
  });
}

void _checkDetails(LocationResult locationResult) {
  expect(locationResult.address.postalCode, jsonDetailsTestPostalCode);
  expect(locationResult.address.street, jsonDetailsTestStreet);
  expect(locationResult.displayPosition.latitude, jsonDetailsTestLat);
  expect(locationResult.displayPosition.longitude, jsonDetailsTestLon);
}
