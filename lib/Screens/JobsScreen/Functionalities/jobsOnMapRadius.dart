import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../Classes/job.dart';

class JobsOnMapRadiusCubit extends Cubit<LatLng> {
  JobsOnMapRadiusCubit({LatLng latLng, String address})
      : this.address = address,
        super(latLng);

  final String address;
  LocationData userLocation;

  Future<List<Job>> getJobs() async {
    final response = await http.get(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${state.latitude},${state.longitude}&type=store&radius=1500&key=GOOGLE_MAPS_API_KEY_HERE');
    final body = json.decode(utf8.decode(response.bodyBytes));
    final features = body['results'] as List;
    List<Job> list = features.map((e) => Job.fromJson(e)).toSet().toList();
    userLocation = await Location().getLocation();

    return list;
  }
}
