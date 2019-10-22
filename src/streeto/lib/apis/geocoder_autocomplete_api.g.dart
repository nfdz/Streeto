// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoder_autocomplete_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionsResponse _$SuggestionsResponseFromJson(Map<String, dynamic> json) {
  return SuggestionsResponse(
    (json['suggestions'] as List)
        ?.map((e) => e == null
            ? null
            : SuggestionEntry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SuggestionsResponseToJson(
        SuggestionsResponse instance) =>
    <String, dynamic>{
      'suggestions': instance.suggestions,
    };

SuggestionEntry _$SuggestionEntryFromJson(Map<String, dynamic> json) {
  return SuggestionEntry(
    json['label'] as String,
    json['locationId'] as String,
    (json['distance'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SuggestionEntryToJson(SuggestionEntry instance) =>
    <String, dynamic>{
      'label': instance.label,
      'locationId': instance.locationId,
      'distance': instance.distance,
    };

ResponseError _$ResponseErrorFromJson(Map<String, dynamic> json) {
  return ResponseError(
    json['error'] as String,
    json['error_description'] as String,
  );
}

Map<String, dynamic> _$ResponseErrorToJson(ResponseError instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_description': instance.errorDescription,
    };
