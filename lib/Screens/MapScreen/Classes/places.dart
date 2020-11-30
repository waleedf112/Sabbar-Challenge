import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

getAddressFromLatLng(LatLng latLng) async {
  final response = await http.get(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude}, ${latLng.longitude}&key=GOOGLE_MAPS_API_KEY_HERE");
  final body = json.decode(utf8.decode(response.bodyBytes));
  String firstAddress = body['results'][0]['address_components'][1]['long_name'];
  String secondAddress = body['results'][0]['address_components'][2]['long_name'];
  return '$firstAddress, $secondAddress';
}

class Place {
  final String name;
  final String secondaryName;
  final String placeId;

  const Place({
    @required this.name,
    this.secondaryName,
    @required this.placeId,
  });

  factory Place.fromJson(Map<String, dynamic> map) {
    final props = map;

    return Place(
      name: props['structured_formatting']['main_text'] ?? '',
      secondaryName: props['structured_formatting']['secondary_text'] ?? '',
      placeId: props['place_id'],
    );
  }

  String get address {
    return '$name, $secondaryName';
  }
}
