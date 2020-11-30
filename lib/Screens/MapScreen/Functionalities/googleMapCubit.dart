import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class GoogleMapCubit extends Cubit<Set<Marker>> {
  GoogleMapCubit() : super(Set<Marker>());

  static Completer<GoogleMapController> controller = Completer();

  initController(GoogleMapController controller) {
    try {
      GoogleMapCubit.controller.complete(controller);
    } catch (e) {}
  }

  Future<void> selectLocationOnMap(LatLng latLng) async {
    final GoogleMapController controller = await GoogleMapCubit.controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 15)));
  }

  Future<void> moveCameraToCurrentLocation() async {
    final GoogleMapController controller = await GoogleMapCubit.controller.future;
    LocationData _locationData = await getCurrentLocation();
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_locationData.latitude, _locationData.longitude),
          zoom: 15,
        ),
      ),
    );
  }

  Future<LocationData> getCurrentLocation() async {
    LocationData _location = await Location().getLocation();
    return _location;
  }

  Future<void> selectOnMap(String placeId) async {
    final response =
        await http.get("https://maps.googleapis.com/maps/api/geocode/json?place_id=$placeId&key=GOOGLE_MAPS_API_KEY_HERE");
    final body = json.decode(utf8.decode(response.bodyBytes));
    Map location = body['results'][0]['geometry']['viewport']['northeast'];
    await selectLocationOnMap(LatLng(
      location['lat'],
      location['lng'],
    ));
  }

  void changeMarker(argument) {
    print(argument);

    Marker marker = Marker(
      markerId: MarkerId('markedLocation'),
      position: LatLng(argument.latitude, argument.longitude),
    );
    emit({marker});
  }
}
