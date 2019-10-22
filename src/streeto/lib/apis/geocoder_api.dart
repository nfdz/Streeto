import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:streeto/common/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geocoder_api.g.dart';
part "geocoder_api.chopper.dart";

// Any change here run -> flutter packages pub run build_runner build --delete-conflicting-outputs
@ChopperApi(baseUrl: "http://geocoder.api.here.com/6.2/geocode.json")
abstract class GeocoderApi extends ChopperService {
  static GeocoderApi create([ChopperClient client]) => _$GeocoderApi(client);

  @Get()
  Future<Response<DetailsResponse>> getDetails({
    @Query("app_id") String appId = kHereApiAppId,
    @Query("app_code") String appCode = kHereApiAppCode,
    @Query("gen") gen = 9,
    @Query("jsonattributes") jsonAttributes = 1,
    @Query("locationid") String locationId,
  });
}

// GeocoderApi DTOs

@JsonSerializable()
class DetailsResponse {
  final ResponseContent response;
  DetailsResponse(this.response);
  static const fromJsonFactory = _$DetailsResponseFromJson;
  static DetailsResponse fromJson(Map<String, dynamic> json) => _$DetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsResponseToJson(this);
}

@JsonSerializable()
class ResponseContent {
  final List<View> view;
  ResponseContent(this.view);
  static const fromJsonFactory = _$ResponseContentFromJson;
  static ResponseContent fromJson(Map<String, dynamic> json) => _$ResponseContentFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseContentToJson(this);
}

@JsonSerializable()
class View {
  final List<Result> result;
  View(this.result);
  static const fromJsonFactory = _$ViewFromJson;
  static View fromJson(Map<String, dynamic> json) => _$ViewFromJson(json);
  Map<String, dynamic> toJson() => _$ViewToJson(this);
}

@JsonSerializable()
class Result {
  final LocationResult location;
  Result(this.location);
  static const fromJsonFactory = _$ResultFromJson;
  static Result fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class LocationResult {
  final DisplayPosition displayPosition;
  final Address address;
  LocationResult(this.displayPosition, this.address);
  static const fromJsonFactory = _$LocationResultFromJson;
  static LocationResult fromJson(Map<String, dynamic> json) => _$LocationResultFromJson(json);
  Map<String, dynamic> toJson() => _$LocationResultToJson(this);
}

@JsonSerializable()
class DisplayPosition {
  final double latitude;
  final double longitude;
  DisplayPosition(this.latitude, this.longitude);
  static const fromJsonFactory = _$DisplayPositionFromJson;
  static DisplayPosition fromJson(Map<String, dynamic> json) => _$DisplayPositionFromJson(json);
  Map<String, dynamic> toJson() => _$DisplayPositionToJson(this);
}

@JsonSerializable()
class Address {
  final String street;
  final String postalCode;
  Address(this.street, this.postalCode);
  static const fromJsonFactory = _$AddressFromJson;
  static Address fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
