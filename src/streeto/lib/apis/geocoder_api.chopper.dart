// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoder_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$GeocoderApi extends GeocoderApi {
  _$GeocoderApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = GeocoderApi;

  Future<Response<DetailsResponse>> getDetails(
      {String appId = kHereApiAppId,
      String appCode = kHereApiAppCode,
      dynamic gen = 9,
      dynamic jsonAttributes = 1,
      String locationId}) {
    final $url = 'http://geocoder.api.here.com/6.2/geocode.json';
    final Map<String, dynamic> $params = {
      'app_id': appId,
      'app_code': appCode,
      'gen': gen,
      'jsonattributes': jsonAttributes,
      'locationid': locationId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<DetailsResponse, DetailsResponse>($request);
  }
}
