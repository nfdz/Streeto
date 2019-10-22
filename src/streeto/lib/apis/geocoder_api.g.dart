// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoder_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsResponse _$DetailsResponseFromJson(Map<String, dynamic> json) {
  return DetailsResponse(
    json['response'] == null
        ? null
        : ResponseContent.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DetailsResponseToJson(DetailsResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
    };

ResponseContent _$ResponseContentFromJson(Map<String, dynamic> json) {
  return ResponseContent(
    (json['view'] as List)
        ?.map(
            (e) => e == null ? null : View.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResponseContentToJson(ResponseContent instance) =>
    <String, dynamic>{
      'view': instance.view,
    };

View _$ViewFromJson(Map<String, dynamic> json) {
  return View(
    (json['result'] as List)
        ?.map((e) =>
            e == null ? null : Result.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ViewToJson(View instance) => <String, dynamic>{
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['location'] == null
        ? null
        : LocationResult.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'location': instance.location,
    };

LocationResult _$LocationResultFromJson(Map<String, dynamic> json) {
  return LocationResult(
    json['displayPosition'] == null
        ? null
        : DisplayPosition.fromJson(
            json['displayPosition'] as Map<String, dynamic>),
    json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationResultToJson(LocationResult instance) =>
    <String, dynamic>{
      'displayPosition': instance.displayPosition,
      'address': instance.address,
    };

DisplayPosition _$DisplayPositionFromJson(Map<String, dynamic> json) {
  return DisplayPosition(
    (json['latitude'] as num)?.toDouble(),
    (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$DisplayPositionToJson(DisplayPosition instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    json['street'] as String,
    json['postalCode'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'postalCode': instance.postalCode,
    };
