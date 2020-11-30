import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/distance.dart' show GoogleDistanceMatrix, Location, DistanceResponse;
import 'package:http/http.dart' as http;

import '../Functionalities/jobsOnMapRadius.dart';

class Job {
  final String type;
  final String company;
  final String photoReference;
  final String creationDate;
  final List<String> details = ['Full time', 'No expereice required', '4 days a week', '739 SAR/M'];
  final Location location;
  double distance;

  static const List<String> jobTypes = [
    'Sales',
    'Delivery',
    'Hospitality',
    'Customer Service',
    'Accountant',
    'Chef',
  ];

  Job({
    @required this.type,
    @required this.company,
    this.photoReference,
    @required this.location,
    @required this.creationDate,
  });
  factory Job.fromJson(data) {
    Random random = new Random();
    int randomNumber = random.nextInt(jobTypes.length);

    return Job(
      type: jobTypes[randomNumber],
      company: data['name'],
      photoReference: data['photos'] != null ? data['photos'][0]['photo_reference'] : null,
      creationDate: '${random.nextInt(8) + 1} days ago',
      location: Location(
        data['geometry']['location']['lat'],
        data['geometry']['location']['lng'],
      ),
    );
  }
  Future<void> calculateDistance(BuildContext context) async {
    final locationData = BlocProvider.of<JobsOnMapRadiusCubit>(context).userLocation;
    final GoogleDistanceMatrix distanceMatrix = GoogleDistanceMatrix(apiKey: 'GOOGLE_MAPS_API_KEY_HERE');
    Location userLocation = Location(locationData.latitude, locationData.longitude);
    DistanceResponse result = (await distanceMatrix.distanceWithLocation([userLocation], [this.location]));
    this.distance = double.parse((result.results[0].elements[0].distance.value / 1000).toStringAsFixed(1));
  }

  Future<dynamic> getPhoto() async {
    final response = await http.get(
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=GOOGLE_MAPS_API_KEY_HERE');
    return response.bodyBytes;
  }
}
